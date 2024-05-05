import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/tumor_stepper/presentation/views/patient_info_view.dart';
import 'package:animation/features/tumor_stepper/presentation/views/result_view.dart';
import 'package:animation/features/tumor_stepper/presentation/views/upload_image_view.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
    required this.currentStep,
  });
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
            background: kPrimaryColor, primary: kSecondaryColor),
      ),
      child: Stepper(
        currentStep: currentStep,
        type: StepperType.horizontal,
        steps: getSteps(),
        controlsBuilder: (context, details) => const SizedBox(),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
            label: const Text(
              'Patient Info',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            isActive: currentStep >= 0,
            content: PatientInfoView()),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: const Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
          label: const Text(
            'Image',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          isActive: currentStep >= 1,
          content: const UploadImageView(),
        ),
        Step(
          title: const Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
          label: const Text(
            'Results',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          isActive: currentStep >= 2,
          content: const ResultView(),
        ),
      ];
}
