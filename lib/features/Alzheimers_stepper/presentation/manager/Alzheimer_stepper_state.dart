part of 'Alzheimer_stepper_cubit.dart';

@immutable
abstract class AlzheimerStepperState {}

class AlzheimerStepperInitial extends AlzheimerStepperState {}
class AlzheimerStepperIncrease extends AlzheimerStepperState {}
class AlzheimerStepperDecrease extends AlzheimerStepperState {}
class AlzheimerStepperField extends AlzheimerStepperState {}

class ImageUploadSuccess extends AlzheimerStepperState {}
class ImageUploadField extends AlzheimerStepperState
{
  final String errMassage;

  ImageUploadField({required this.errMassage});
}
class ImageUploadLoading extends AlzheimerStepperState {}
class ImageRemoveSuccess extends AlzheimerStepperState {}
class AlzheimerPatientInfoLoaded extends AlzheimerStepperState {}
class AlzheimerPatientInfoError extends AlzheimerStepperState {
  final String errMassage;

  AlzheimerPatientInfoError({required this.errMassage});
}
class AlzheimerPatientInfoSaving extends AlzheimerStepperState {}
class AlzheimerPatientInfoSaved extends AlzheimerStepperState {}
class AlzheimerPatientInfoSavingFailure extends AlzheimerStepperState {
  final String errMassage;

  AlzheimerPatientInfoSavingFailure({required this.errMassage});
}





