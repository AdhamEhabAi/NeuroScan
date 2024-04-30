import 'package:animation/core/models/patient_info.dart';
import 'package:animation/features/Autism/data/questions_data/question_data.dart';
import 'package:animation/features/Autism/presentation/views/result_view.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'autism_state.dart';

class AutismCubit extends Cubit<AutismState> {
  AutismCubit() : super(AutismInitial());
  PatientInfo? patientInfo;
  List<dynamic> answers = [];
  int currentQuestionIndex = 0;
  dynamic selectedAnswer;
  double age = 20;



  void setPatientAge({required double patientAge}){
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
        'result': patientInfo.result,
        'userId': patientInfo.userId,
        'number':'+20${patientInfo.userNumber}',
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

  void nextOnPressed({required answerSelected}) {
    if (currentQuestionIndex < questions.length-1) {
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
        Get.off(const ResultView());
        for (var answer in answers) {
          print(answer);
        }
        answers = [];
        currentQuestionIndex = 0;
        selectedAnswer = null;
      }else{
        emit(NoAnswerSelected());
      }
    }
  }
}
