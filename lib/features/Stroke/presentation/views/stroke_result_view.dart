import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/patient_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class StrokeResultView extends StatelessWidget {
  const StrokeResultView({super.key, required this.result});
  final String result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Result',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: BlocConsumer<StrokeCubit, StrokeState>(
        listener: (context, state) {
          if (state is StrokePatientInfoSaved) {
            showSuccessSnackBar(
                context, 'The Patient\'s data saved successfully');
            Get.offAll(const HomeScreen());
          } else if (state is StrokePatientInfoSavingFailure) {
            showFailureSnackBar(context, state.errMassage);
          }
        },
        builder: (context, state) {
          final patientInfo = BlocProvider.of<StrokeCubit>(context).patientInfo;
          if (patientInfo == null) {
            return const Center(
              child: Text(
                'Please Restart The App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            child: ModalProgressHUD(
              inAsyncCall: state is StrokePatientInfoSaving,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        label: 'Age',
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
                    PatientResultWidget(
                        label: 'Phone Number', value: patientInfo.userNumber),
                    const SizedBox(
                      height: 10,
                    ),
                    PatientResultWidget(label: 'Result', value: result),
                    CustomButton(
                        text: 'Save',
                        backGroundColor: kSecondryColor,
                        ontap: () {
                          BlocProvider.of<StrokeCubit>(context)
                              .savePatientDataToCloud(patientInfo: patientInfo);
                          BlocProvider.of<StrokeCubit>(context).selectedImage = null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: 'New Patient',
                      ontap: () {
                        Get.offAll(const HomeScreen());
                        BlocProvider.of<StrokeCubit>(context).selectedImage = null;
                        showHintSnackBar(context, 'Let\'s check new patient');
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
