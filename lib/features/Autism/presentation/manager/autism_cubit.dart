import 'package:animation/core/models/patient_info.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'autism_state.dart';

class AutismCubit extends Cubit<AutismState> {
  AutismCubit() : super(AutismInitial());
  PatientInfo? patientInfo;

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
      emit(AutismPatientInfoSaved());
    } on Exception catch (e) {
      emit(AutismPatientInfoSavingFailure(errMassage: e.toString()));
    }
  }
}
