import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/manager/Alzheimer_stepper_cubit.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/patient_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlzheimerStepperCubit, AlzheimerStepperState>(
      listener: (context, state) {
        if (state is AlzheimerPatientInfoSaved) {
          BlocProvider.of<AlzheimerStepperCubit>(context).currentStep = 0;
          BlocProvider.of<AlzheimerStepperCubit>(context).selectedImage = null;
          showSuccessSnackBar(
              context, 'The Patient\'s data saved successfully');
          Get.offAll(const HomeScreen());
        } else if (state is AlzheimerPatientInfoSavingFailure) {
          showFailureSnackBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        final patientInfo =
            BlocProvider.of<AlzheimerStepperCubit>(context).patientInfo;
        if (patientInfo == null) {
          return const Center(
            child: Text(
              'Please Restart The App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ModalProgressHUD(
          inAsyncCall: state is AlzheimerPatientInfoSaving,
          child: Column(
            children: [
              Stack(children: [
                PatientResultWidget(
                    label: 'Name',
                    value: '${patientInfo.fName} ${patientInfo.lName}'),
                Positioned(
                  right: 20,
                  child: Text(patientInfo.date),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              PatientResultWidget(
                  label: 'Age', value: patientInfo.age.round().toString()),
              const SizedBox(
                height: 10,
              ),
              PatientResultWidget(
                  label: 'Patient Gender',
                  value: patientInfo.isMale ? 'Male' : 'Female'),
              const SizedBox(
                height: 10,
              ),
              PatientResultWidget(
                  label: 'Phone Number', value: patientInfo.userNumber),
              const SizedBox(
                height: 10,
              ),
              const PatientResultWidget(label: 'Result', value: 'False'),
              CustomButton(
                  text: 'Save',
                  backGroundColor: kSecondryColor,
                  ontap: () {
                    BlocProvider.of<AlzheimerStepperCubit>(context)
                        .savePatientDataToCloud(patientInfo: patientInfo);
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'New Patient',
                ontap: () {
                  BlocProvider.of<AlzheimerStepperCubit>(context).currentStep =
                      0;
                  BlocProvider.of<AlzheimerStepperCubit>(context)
                      .selectedImage = null;
                  Get.offAll(const HomeScreen());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
