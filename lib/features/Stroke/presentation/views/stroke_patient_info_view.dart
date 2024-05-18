import 'dart:math';

import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:animation/features/Stroke/presentation/views/image_or_questions_view.dart';
import 'package:animation/features/Stroke/presentation/views/widgets/age_slider_widget.dart';
import 'package:animation/features/Stroke/presentation/views/widgets/sex_square_widget.dart';
import 'package:animation/features/authentication/presentation/views/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;
import 'package:intl/intl.dart';

class StrokePatientInfoView extends StatefulWidget {
  const StrokePatientInfoView({super.key});

  @override
  State<StrokePatientInfoView> createState() => _StrokePatientInfoViewState();
}

class _StrokePatientInfoViewState extends State<StrokePatientInfoView> {
  bool isMale = true;
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController massController = TextEditingController();
  final TextEditingController glController = TextEditingController();


  double age = 20;
  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    phoneNumberController.dispose();
    heightController.dispose();
    massController.dispose();
    glController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          title: const Text(
            'Patient information',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                trans.Get.back();
                BlocProvider.of<StrokeCubit>(context).selectedAnswer = null;
                BlocProvider.of<StrokeCubit>(context).answers = [];
                BlocProvider.of<StrokeCubit>(context).currentQuestionIndex = 0;
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      prefix: const Icon(Icons.person),
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
                      prefix: const Icon(Icons.person),
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
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      prefix: const Icon(Icons.phone),
                      controller: phoneNumberController,
                      textInputType: TextInputType.phone,
                      labelText: 'Phone Number',
                      hintText: 'Phone Number',
                      validator: (value) {
                        RegExp regExp = RegExp(r"^(012|010|011|015)\d{8}$");
                        if (value!.isEmpty) {
                          return 'This Field is required';
                        } else if (regExp.hasMatch(value)) {
                          return null;
                        } else {
                          return 'Enter Valid Number';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      prefix: const Icon(Icons.numbers_outlined),
                      controller: glController,
                      textInputType: TextInputType.number,
                      labelText: 'Average glucose level',
                      hintText: 'Average glucose level',
                      validator: (value) {
                        int gl = int.parse(glController.text);
                        if (value!.isEmpty) {
                          return 'This Field is required';
                        } else if(gl < 0){
                          return "Enter positive number";
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            prefix: const Icon(Icons.numbers_outlined),
                            controller: heightController,
                            textInputType: TextInputType.number,
                            labelText: 'Height',
                            hintText: 'Height',
                            validator: (value) {
                              int height = int.parse(heightController.text);
                              if (value!.isEmpty) {
                                return 'This Field is required';
                              } else if(height < 0){
                                return "Enter positive number";
                              }else{
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: CustomTextField(
                            prefix: const Icon(Icons.numbers_outlined),
                            controller: massController,
                            textInputType: TextInputType.number,
                            labelText: 'Body Mass',
                            hintText: 'Body Mass',
                            validator: (value) {
                              int mass = int.parse(massController.text);
                              if (value!.isEmpty) {
                                return 'This Field is required';
                              } else if(mass < 0){
                                return "Enter positive number";
                              }else{
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    StrokeAgeSliderWidget(age: age),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StrokeSexSquareWidget(
                          img: 'assets/images/man.png',
                          gender: 'Male',
                          isMale: isMale,
                          ontap: () {
                            setState(() {
                              isMale = true;
                            });
                          },
                        ),
                        StrokeSexSquareWidget(
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
                      height: 40,
                    ),
                    CustomButton(
                        text: 'Let\'s Start',
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            String formattedDate =
                                DateFormat('yyyy/MM/dd').format(DateTime.now());

                            String? userId =
                                FirebaseAuth.instance.currentUser?.uid;
                            int height = int.parse(heightController.text);
                            int mass = int.parse(massController.text);
                            int gl = int.parse(glController.text);
                            double bmi = mass / pow(height / 100, 2);

                            BlocProvider.of<StrokeCubit>(context)
                                .setPatientInfo(
                              patient: PatientInfo(
                                bmi: bmi,
                                gLevel: gl,
                                userNumber: phoneNumberController.text,
                                userId: userId!,
                                disease: 'Stroke',
                                date: formattedDate,
                                fName: firstNameController.text,
                                lName: secondNameController.text,
                                age: BlocProvider.of<StrokeCubit>(context).age,
                                isMale: isMale,
                              ),
                            );
                            trans.Get.to(const ImageOrQuestionView(),
                                transition: trans.Transition.rightToLeft);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
