part of 'stroke_cubit.dart';

@immutable
sealed class StrokeState {}

final class StrokeInitial extends StrokeState {}

final class SetPatientAgeSuccess extends StrokeState {}

final class StrokePatientInfoLoaded extends StrokeState {}

final class StrokePatientInfoError extends StrokeState {
  final String errMassage;

  StrokePatientInfoError({required this.errMassage});
}

final class StrokePatientInfoSaving extends StrokeState {}

final class StrokePatientInfoSaved extends StrokeState {}

final class StrokePatientInfoSavingFailure extends StrokeState {
  final String errMassage;

  StrokePatientInfoSavingFailure({required this.errMassage});
}

final class ImageUploadLoading extends StrokeState {}
final class ImageUploadSuccess extends StrokeState {}
final class ImageUploadField extends StrokeState {
  final String errMassage;

  ImageUploadField({required this.errMassage});
}
final class ImageRemoveSuccess extends StrokeState {}

final class AnswerSelected extends StrokeState{
  final dynamic answer;

  AnswerSelected({required this.answer});
}
final class NoAnswerSelected extends StrokeState {}
final class NextQuestion extends StrokeState {}
final class OutOfRange extends StrokeState {}


final class PredictionSuccess extends StrokeState {
  final String result;

  PredictionSuccess({required this.result});
}
final class PredictionField extends StrokeState {
  final String errMassage;

  PredictionField({required this.errMassage});
}
final class PredictionLoading extends StrokeState {}


