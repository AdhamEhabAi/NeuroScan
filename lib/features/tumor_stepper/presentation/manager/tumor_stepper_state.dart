part of 'tumor_stepper_cubit.dart';

@immutable
abstract class TumorStepperState {}

class TumorStepperInitial extends TumorStepperState {}

class TumorStepperIncrease extends TumorStepperState {}

class TumorStepperDecrease extends TumorStepperState {}

class TumorStepperField extends TumorStepperState {}

class ImageUploadSuccess extends TumorStepperState {}

class ImageUploadField extends TumorStepperState {
  final String errMassage;

  ImageUploadField({required this.errMassage});
}

class ImageUploadLoading extends TumorStepperState {}

class ImageRemoveSuccess extends TumorStepperState {}

class TumorPatientInfoLoaded extends TumorStepperState {}

class TumorPatientInfoError extends TumorStepperState {
  final String errMessage;

  TumorPatientInfoError({required this.errMessage});

}




class TumorPatientInfoSaved extends TumorStepperState {}
class TumorPatientInfoSavingFailure extends TumorStepperState {
  final String errMassage;

  TumorPatientInfoSavingFailure({required this.errMassage});
}
class TumorPatientInfoSaving extends TumorStepperState {}

