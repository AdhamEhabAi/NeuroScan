import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/authentication/presentation/views/widgets/email_validator.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/social_containers.dart';
import  'package:get/get_navigation/src/routes/transitions_type.dart' as trans;


class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? email;
  String? password;
  bool isLoading = false;
  bool isSeen = false;
  GlobalKey<FormState> formKey = GlobalKey();
  
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
          showHintSnackBar(context, 'Please Wait');
        } else if (state is RegisterSuccess) {
          BlocProvider.of<AuthCubit>(context).getUser();
          Get.offAll(
            const HomeScreen(),
            transition: trans.Transition.fadeIn,
          );
          showSuccessSnackBar(context, 'Register Success');
          isLoading = false;
        } else if (state is RegisterFailure) {
          showFailureSnackBar(context, state.errMassage);
          isLoading = false;
        }
        if(state is passwordIsSeen){
          isSeen = true;
        }else if (state is passwordIsHidden){
          isSeen = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image.asset(kLogo,width: 220,),
                        const Row(
                          children: [
                            Text(
                              'Create your Account',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'this field is required';
                            } else {
                              return validateEmail(value);
                            }
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          prefix: const Icon(Icons.email_outlined),
                          hintText: 'Email',
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                            textInputType: TextInputType.visiblePassword,
                            controller: passController,
                            prefix: const Icon(Icons.lock_outline_rounded),
                            suffix: InkWell(
                              onTap: (){
                                BlocProvider.of<AuthCubit>(context).changePasswordState(isSeen: isSeen);
                              },
                              child: isSeen == false ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            ),
                            obsecureText: isSeen == false ? true: false,
                            hintText: 'Password',
                            labelText: 'Password'),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field is required';
                              } else if (value != passController.text) {
                                return 'Not Match';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            textInputType: TextInputType.visiblePassword,
                            controller: confirmPassController,
                            prefix: const Icon(Icons.lock_outline_rounded),
                            suffix: InkWell(
                              onTap: (){
                                BlocProvider.of<AuthCubit>(context).changePasswordState(isSeen: isSeen);
                              },
                              child: isSeen == false ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            ),
                            obsecureText: isSeen == false ? true: false,
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password'),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerEmailPassword(
                                      email: email!, password: password!);
                            } else {}
                          },
                          text: 'Sign Up',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '-Or Sign Up with-',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              SocialContainers(
                                imagePath: 'assets/images/google.png',
                                ontap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .signInWithGoogle();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
