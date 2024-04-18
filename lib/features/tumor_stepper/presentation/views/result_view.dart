import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_snack_bar.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:animation/features/tumor_stepper/presentation/manager/tumor_stepper_cubit.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/patient_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TumorStepperCubit, TumorStepperState>(
      listener: (context, state) {
        if(state is TumorPatientInfoSaved)
        {
          BlocProvider.of<TumorStepperCubit>(context).currentStep = 0;
          BlocProvider.of<TumorStepperCubit>(context).selectedImage =
          null;
          showSnackBar(context,'The Patient\'s data saved successfully');
          Get.offAll(const HomeScreen());
        }else if (state is TumorPatientInfoSavingFailure){
          showSnackBar(context,state.errMassage);
        }
      },
      builder: (context, state) {
        final patientInfo =
            BlocProvider.of<TumorStepperCubit>(context).patientInfo;
        if (patientInfo == null) {
          return const Center(
            child: Text('Please Restart The App'),
          );
        }
        return ModalProgressHUD(
          inAsyncCall: state is TumorPatientInfoSaving,
          child: Column(
            children: [
              Stack(children: [
                PatientResultWidget(
                    label: 'Patient Name',
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
                  label: 'Patient Age',
                  value: patientInfo.age.round().toString()),
              const SizedBox(
                height: 10,
              ),
              PatientResultWidget(
                  label: 'Patient Gender',
                  value: patientInfo.isMale ? 'Male' : 'Female'),
              const SizedBox(
                height: 10,
              ),
              const PatientResultWidget(label: 'Result', value: 'False'),
              CustomButton(
                text: 'Save',
                backGroundColor: kSecondryColor,
                ontap: () {
                  BlocProvider.of<TumorStepperCubit>(context)
                      .savePatientDataToCloud(patientInfo: patientInfo);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'New Patient',
                ontap: () {
                  BlocProvider.of<TumorStepperCubit>(context).currentStep = 0;
                  BlocProvider.of<TumorStepperCubit>(context).selectedImage =
                      null;
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
