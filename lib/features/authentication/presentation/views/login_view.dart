import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/authentication/presentation/views/forget_password_view.dart';
import 'package:animation/features/authentication/presentation/views/register_view.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/features/authentication/presentation/views/widgets/custom_text_field.dart';
import 'package:animation/features/authentication/presentation/views/widgets/email_validator.dart';
import 'package:animation/features/authentication/presentation/views/widgets/social_containers.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as trans;

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String? email, password;
  bool isLoading = false;
  bool isSeen = false;
  GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<AuthCubit>(context).getUser();
          Get.offAll(
            const HomeScreen(),
            transition: trans.Transition.fadeIn,
          );
          showSuccessSnackBar(context, 'Login Success');
          isLoading = false;
        } else if (state is LoginFailure) {
          showFailureSnackBar(context, state.errMassage);
          isLoading = false;
        }

        if (state is passwordIsSeen) {
          isSeen = true;
        } else if (state is passwordIsHidden) {
          isSeen = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is LoginLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        kLogo,
                        width: 220,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Login to your Account',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                        onChanged: (data) {
                          email = data;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          } else {
                            return validateEmail(value);
                          }
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
                          onChanged: (data) {
                            password = data;
                          },
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
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .changePasswordState(isSeen: isSeen);
                            },
                            child: isSeen == false
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          obsecureText: isSeen == false ? true : false,
                          hintText: 'Password',
                          labelText: 'Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Get.to(ForgetPasswordView(),transition: trans.Transition.fadeIn);
                            },
                            child: Text(
                              'Forget password ?',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        ontap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .loginEmailPassword(
                                    email: email!, password: password!);
                          } else {}
                        },
                        text: 'Sign in',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '-Or Sign in with-',
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
                      Row(
                        children: [
                          const Text(
                            'Don\'t have an account',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(RegisterPage(),
                                  transition:
                                      trans.Transition.leftToRightWithFade);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
