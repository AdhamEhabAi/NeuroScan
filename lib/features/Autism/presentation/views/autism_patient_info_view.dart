
import 'package:animation/core/models/patient_info.dart';
import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/features/Autism/presentation/manager/autism_cubit.dart';
import 'package:animation/features/Autism/presentation/views/questions_view.dart';
import 'package:animation/features/Autism/presentation/views/widgets/age_slider_widget.dart';
import 'package:animation/features/Autism/presentation/views/widgets/sex_square_widget.dart';
import 'package:animation/features/authentication/presentation/views/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;
import 'package:intl/intl.dart';

class AutismPatientInfoView extends StatefulWidget {
  const AutismPatientInfoView({super.key});

  @override
  State<AutismPatientInfoView> createState() => _AutismPatientInfoViewState();
}

class _AutismPatientInfoViewState extends State<AutismPatientInfoView> {
  bool isMale = true;
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  double age = 20;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          title: const Text(
            'Patient information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
          ),
          leading: IconButton(onPressed: ()
          {
            trans.Get.back();
          },icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: firstNameController,
                      textInputType: TextInputType.text,
                      labelText: 'First Name',
                      hintText: 'First Name',
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'This Field is required';
                        }else
                        {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20,),

                    CustomTextField(
                      controller: secondNameController,
                      textInputType: TextInputType.text,
                      labelText: 'Last Name',
                      hintText: 'Last Name',
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'This Field is required';
                        }else
                        {
                          return null;
                        }
                      },
                    ),
                    AgeSliderWidget(age: age),
                    const SizedBox(height: 20,),

                    const Text(
                      'Gender',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20,),

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
                    const SizedBox(height: 40,),

                    CustomButton(
                        text: 'Questions',
                        ontap: () {
                          if(formKey.currentState!.validate())
                          {
                            String formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());
          
                            String? userId = FirebaseAuth.instance.currentUser?.uid;
          
                            BlocProvider.of<AutismCubit>(context)
                                .setPatientInfo(
                              patient: PatientInfo(
                                userId: userId!,
                                result: 'true',
                                disease: 'Alzheimer',
                                date: formattedDate,
                                fName: firstNameController.text,
                                lName: secondNameController.text,
                                age: age,
                                isMale: isMale,
                              ),
                            );
                            trans.Get.to(QuestionsView(),transition: trans.Transition.rightToLeft);
                          }
                        }
                    ),
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

