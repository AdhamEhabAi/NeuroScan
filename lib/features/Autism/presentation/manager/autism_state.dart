part of 'autism_cubit.dart';

@immutable
sealed class AutismState {}

final class AutismInitial extends AutismState {}
final class AutismPatientInfoLoaded extends AutismState {}
final class AutismPatientInfoError extends AutismState {
  final String errMassage;

  AutismPatientInfoError({required this.errMassage});
}

final class SetPatientAgeSuccess extends AutismState {}

final class AutismPatientInfoSaving extends AutismState {}
final class AutismPatientInfoSaved extends AutismState {}

final class AutismPatientInfoSavingFailure extends AutismState {
  final String errMassage;

  AutismPatientInfoSavingFailure({required this.errMassage});

}
final class AnswerSelected extends AutismState{
  final dynamic answer;

  AnswerSelected({required this.answer});
}
final class NoAnswerSelected extends AutismState{}

final class NextQuestion extends AutismState{}
final class OutOfRange extends AutismState{}


final class PredictionLoading extends AutismState{}
final class PredictionSuccess extends AutismState{}
final class PredictionFailure extends AutismState{
  final String errMassage;

  PredictionFailure({required this.errMassage});

}


