import 'dart:io';

import 'package:animation/core/models/patient_info.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'Alzheimer_stepper_state.dart';

class AlzheimerStepperCubit extends Cubit<AlzheimerStepperState> {
  AlzheimerStepperCubit() : super(AlzheimerStepperInitial());
  int currentStep = 0;
  File? selectedImage;
  PatientInfo? patientInfo;


  void increaseStepper() {
    if (currentStep < 2) {
      currentStep += 1;
      emit(AlzheimerStepperIncrease());
    }
  }

  void decreaseStepper() {
    if (currentStep > 0) {
      currentStep -= 1;
      emit(AlzheimerStepperDecrease());
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      emit(ImageUploadLoading());
      final galleryImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (galleryImage != null) {
        selectedImage = File(galleryImage.path);
        emit(ImageUploadSuccess());
      } else {
        emit(ImageUploadField(errMassage: 'No image selected'));
      }
    } on PlatformException catch (e) {
      emit(ImageUploadField(errMassage: 'Error: ${e.message}'));
    } catch (e) {
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
      emit(AlzheimerPatientInfoLoaded());
    } on Exception catch (e) {
      emit(AlzheimerPatientInfoError(errMassage: e.toString()));
    }
  }
  void savePatientDataToCloud({required PatientInfo patientInfo}) async {
    try {
      emit(AlzheimerPatientInfoSaving());
      CollectionReference patient = FirebaseFirestore.instance.collection('patients');
      patient.add({
        'age': patientInfo.age.round().toString(),
        'date': patientInfo.date,
        'disease': patientInfo.disease,
        'fName': patientInfo.fName,
        'isMale': patientInfo.isMale,
        'lName': patientInfo.lName,
        'result': patientInfo.result,
        'userId': patientInfo.userId,
      });
      emit(AlzheimerPatientInfoSaved());
    } on Exception catch (e) {
      emit(AlzheimerPatientInfoSavingFailure(errMassage: e.toString()));
    }
  }

}
