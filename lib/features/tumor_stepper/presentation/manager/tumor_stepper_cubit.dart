import 'dart:io';

import 'package:animation/core/models/patient_info.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'tumor_stepper_state.dart';

class TumorStepperCubit extends Cubit<TumorStepperState> {
  TumorStepperCubit() : super(TumorStepperInitial());
  int currentStep = 0;
  File? selectedImage;
  PatientInfo? patientInfo;
  double age = 20;

  void setPatientAge({required double patientAge})
  {
    age = patientAge;
    emit(SetPatientAgeSuccess());
  }
  void increaseStepper() {
    if (currentStep < 2) {
      currentStep += 1;
      emit(TumorStepperIncrease());
    }
  }

  void decreaseStepper() {
    if (currentStep > 0) {
      currentStep -= 1;
      emit(TumorStepperDecrease());
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      emit(ImageUploadLoading());
      final galleryImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (galleryImage != null) {
        selectedImage = File(galleryImage.path);
        emit(ImageUploadSuccess());
      } else {
        emit(ImageUploadField(errMassage: 'No image selected'));
      }
    } on PlatformException catch (e) {
      emit(ImageUploadField(errMassage: 'Error: ${e.message}'));
    } on Exception catch (e) {
      emit(ImageUploadField(errMassage: 'Error: ${e.toString()}'));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImageRemoveSuccess());
  }

  void setPatientInfo({required PatientInfo patient}) {
    try {
      patientInfo = patient;
      emit(TumorPatientInfoLoaded());
    } on Exception catch (e) {
      emit(TumorPatientInfoError(errMessage: e.toString()));
    }
  }

  void savePatientDataToCloud({required PatientInfo patientInfo}) async {
    try {
      emit(TumorPatientInfoSaving());
      CollectionReference patient =
          FirebaseFirestore.instance.collection('patients');
      patient.add({
        'age': patientInfo.age.round().toString(),
        'date': patientInfo.date,
        'disease': patientInfo.disease,
        'fName': patientInfo.fName,
        'isMale': patientInfo.isMale,
        'lName': patientInfo.lName,
        'result': patientInfo.result,
        'userId': patientInfo.userId,
        'number': '+2${patientInfo.userNumber}',
      });
      emit(TumorPatientInfoSaved());
    } on Exception catch (e) {
      emit(TumorPatientInfoSavingFailure(errMassage: e.toString()));
    }
  }


}
