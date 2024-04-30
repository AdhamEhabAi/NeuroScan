import 'dart:convert';
import 'dart:io';

import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/models/prediction_model.dart';
import 'package:animation/core/utils/api_services.dart';
import 'package:animation/features/Stroke/data/questions_data/question_data.dart';
import 'package:animation/features/Stroke/presentation/views/stroke_result_view.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'stroke_state.dart';

class StrokeCubit extends Cubit<StrokeState> {
  StrokeCubit(this.apiService) : super(StrokeInitial());
  PatientInfo? patientInfo;
  List<dynamic> answers = [];
  int currentQuestionIndex = 0;
  String result = '';
  dynamic selectedAnswer;
  double age = 20;
  File? selectedImage;
  final ApiService apiService;

  void setPatientAge({required double patientAge}) {
    age = patientAge;
    emit(SetPatientAgeSuccess());
  }

  void setPatientInfo({required PatientInfo patient}) {
    try {
      patientInfo = patient;
      emit(StrokePatientInfoLoaded());
    } on Exception catch (e) {
      emit(StrokePatientInfoError(errMassage: e.toString()));
    }
  }

  void savePatientDataToCloud({required PatientInfo patientInfo}) async {
    try {
      emit(StrokePatientInfoSaving());
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
        'number': '+20${patientInfo.userNumber}',
      });
      emit(StrokePatientInfoSaved());
    } on Exception catch (e) {
      emit(StrokePatientInfoSavingFailure(errMassage: e.toString()));
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
    } catch (e) {
      emit(ImageUploadField(errMassage: 'Error: ${e.toString()}'));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImageRemoveSuccess());
  }

  void setSelectedAnswer({required dynamic answer}) {
    selectedAnswer = answer;
    emit(AnswerSelected(answer: answer));
  }

  void nextOnPressed({required answerSelected}) {
    if (currentQuestionIndex < stokeQuestions.length - 1) {
      if (answerSelected == null) {
        emit(NoAnswerSelected());
      } else {
        answers.add(answerSelected);
        selectedAnswer = null;
        currentQuestionIndex += 1;
        emit(NextQuestion());
      }
    } else {
      // here i can get the answers
      if (answerSelected != null) {
        answers.add(answerSelected);
        emit(OutOfRange());
        Get.off(StrokeResultView(result: result,));
        for (var answer in answers) {
          print(answer);
        }
        answers = [];
        currentQuestionIndex = 0;
        selectedAnswer = null;
      } else {
        emit(NoAnswerSelected());
      }
    }
  }

  Future<void> getPredictionResult() async {
    emit(PredictionLoading());
    if (selectedImage == null) {
      emit(PredictionField(errMassage: 'No image selected'));  // Corrected naming
      return;
    }

    try {
      final response = await apiService.postRequest(
        function: 'predict_stroke',
        file: selectedImage!,  // Pass the file directly
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prediction = PredictionModel.fromJson(responseData);
        result = prediction.prediction;
        emit(PredictionSuccess());  // You can also emit with prediction details
      } else {
        emit(PredictionField(errMassage: 'Failed to get prediction'));
      }
    } catch (e) {
      emit(PredictionField(errMassage: 'Error: $e'));
      print(e.toString());// Proper error handling
    }
  }

}
