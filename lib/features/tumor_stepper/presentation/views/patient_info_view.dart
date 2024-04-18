import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/authentication/presentation/views/widgets/custom_text_field.dart';
import 'package:animation/features/tumor_stepper/presentation/manager/tumor_stepper_cubit.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/age_slider_widget.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/sex_square_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PatientInfoView extends StatefulWidget {
  const PatientInfoView({super.key});

  @override
  State<PatientInfoView> createState() => _PatientInfoViewState();
}

class _PatientInfoViewState extends State<PatientInfoView> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  bool isMale = true;
  double age = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the Patient information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: firstNameController,
                textInputType: TextInputType.text,
                labelText: 'First Name',
                hintText: 'First Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: secondNameController,
                textInputType: TextInputType.text,
                labelText: 'Last Name',
                hintText: 'Last Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is required';
                  } else {
                    return null;
                  }
                },
              ),
              AgeSliderWidget(age: age),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SexSquareWidget(
                        img: 'assets/images/man.png',
                        gender: 'Male',
                        isMale: isMale,
                        ontap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                      ),
                      SexSquareWidget(
                        img: 'assets/images/hairstyle.png',
                        gender: 'Female',
                        isMale: !isMale,
                        ontap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Continue',
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        String formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());
                        String? userId = FirebaseAuth.instance.currentUser?.uid;
                        BlocProvider.of<TumorStepperCubit>(context)
                            .setPatientInfo(
                          patient: PatientInfo(
                            userId: userId!,
                            result: 'true',
                            disease: 'Tumor',
                            date: formattedDate,
                            fName: firstNameController.text,
                            lName: secondNameController.text,
                            age: age,
                            isMale: isMale,
                          ),
                        );
                        BlocProvider.of<TumorStepperCubit>(context)
                            .increaseStepper();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}