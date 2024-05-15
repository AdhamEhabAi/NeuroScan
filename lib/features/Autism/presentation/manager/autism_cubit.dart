import 'dart:convert';

import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/models/prediction_model.dart';
import 'package:animation/core/utils/api_services.dart';
import 'package:animation/features/Autism/data/questions_data/question_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'autism_state.dart';

class AutismCubit extends Cubit<AutismState> {
  AutismCubit(this.apiService) : super(AutismInitial());
  PatientInfo? patientInfo;
  List<dynamic> answers = [];
  int currentQuestionIndex = 0;
  dynamic selectedAnswer;
  double age = 20;
  final ApiService apiService;
  String result = '';

  void setPatientAge({required double patientAge}) {
    age = patientAge;
    emit(SetPatientAgeSuccess());
  }

  void setPatientInfo({required PatientInfo patient}) {
    try {
      patientInfo = patient;
      emit(AutismPatientInfoLoaded());
    } on Exception catch (e) {
      emit(AutismPatientInfoError(errMassage: e.toString()));
    }
  }

  void savePatientDataToCloud({required PatientInfo patientInfo}) async {
    try {
      emit(AutismPatientInfoSaving());
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
      emit(AutismPatientInfoSaved());
    } on Exception catch (e) {
      emit(AutismPatientInfoSavingFailure(errMassage: e.toString()));
    }
  }

  void setSelectedAnswer({required dynamic answer}) {
    selectedAnswer = answer;
    emit(AnswerSelected(answer: answer));
  }

  void nextOnPressed({required dynamic answerSelected}) {
    if (currentQuestionIndex < questions.length - 1) {
      if (answerSelected == null) {
        emit(NoAnswerSelected());
      } else {
        addAnswerToAnswersList(currentQuestionIndex, answerSelected);
        selectedAnswer = null;
        currentQuestionIndex += 1;
        emit(NextQuestion());
      }
    } else {
      if (answerSelected != null) {
        addAnswerToAnswersList(currentQuestionIndex, answerSelected);
        getPrediction();
      } else {
        emit(NoAnswerSelected());
      }
    }
  }
  void addAnswerToAnswersList(int questionIndex, dynamic answerSelected) {
    if ([1, 7, 8, 10].contains(questionIndex)) {
      if (answerSelected == 'Definitely Agree' ||
          answerSelected == 'Slightly Agree') {
        answers.add(1);
      } else {
        answers.add(0);
      }
    } else {
      if (answerSelected == 'Slightly Disagree' ||
          answerSelected == 'Definitely Disagree') {
        answers.add(1);
      } else {
        answers.add(0);
      }
    }
  }

  Future<void> getPrediction() async {
    emit(PredictionLoading());
    try {
      answers.add(patientInfo!.age);
      answers.add(patientInfo!.isMale ? 1 : 0 );
      answers.add(0);
      answers.add(0);
      final response = await apiService
          .postRequestForQuestions(function: 'predict_Autism', headers: {
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        "features": answers,
      }));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final prediction = PredictionModel.fromJson(responseData);
        result = prediction.prediction;
        emit(PredictionSuccess()); // You can also emit with prediction details
      } else {
        emit(PredictionFailure(errMassage: 'Failed to get prediction'));
      }
    } catch (e) {
      emit(PredictionFailure(errMassage: 'Failed to get prediction'));
      print(e.toString()); // Proper error handling
    }
  }
  void reset() {
    answers = [];
    currentQuestionIndex = 0;
    selectedAnswer = null;
    emit(AutismInitial());
  }

}
