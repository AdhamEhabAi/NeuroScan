import 'dart:convert';
import 'dart:io';
import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/models/prediction_model.dart';
import 'package:animation/core/utils/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'Alzheimer_stepper_state.dart';

class AlzheimerStepperCubit extends Cubit<AlzheimerStepperState> {
  AlzheimerStepperCubit(this.apiService) : super(AlzheimerStepperInitial());
  int currentStep = 0;
  File? selectedImage;
  PatientInfo? patientInfo;
  double age = 20;
  String result = '';
  final ApiService apiService;

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

  void setPatientAge({required double patientAge}) {
    age = patientAge;
    emit(SetPatientAgeSuccess());
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
      CollectionReference patient =
          FirebaseFirestore.instance.collection('patients');
      patient.add({
        'age': patientInfo.age.round().toString(),
        'date': patientInfo.date,
        'disease': patientInfo.disease,
        'fName': patientInfo.fName,
        'isMale': patientInfo.isMale,
        'lName': patientInfo.lName,
        'result': result,
        'userId': patientInfo.userId,
        'number': '+2${patientInfo.userNumber}',
      });
      emit(AlzheimerPatientInfoSaved());
    } on Exception catch (e) {
      emit(AlzheimerPatientInfoSavingFailure(errMassage: e.toString()));
    }
  }

  Future<void> getPredictionResult() async {
    emit(PredictionLoading());
    if (selectedImage == null) {
      emit(
          PredictionField(errMassage: 'No image selected')); // Corrected naming
      return;
    }

    try {
      final response = await apiService.postRequestImage(
        function: 'predict_alzheimer',
        file: selectedImage!, // Pass the file directly
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prediction = PredictionModel.fromJson(responseData);
        result = prediction.prediction;
        emit(PredictionSuccess()); // You can also emit with prediction details
      } else {
        emit(PredictionField(errMassage: 'Failed to get prediction'));
      }
    } catch (e) {
      emit(PredictionField(errMassage: 'Failed to get prediction'));
      print(e.toString()); // Proper error handling
    }
  }
}
