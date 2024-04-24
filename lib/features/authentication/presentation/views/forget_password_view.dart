import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:animation/features/authentication/presentation/views/widgets/custom_text_field.dart';
import 'package:animation/features/authentication/presentation/views/widgets/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final TextEditingController resetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetEmailSuccess) {
          showSuccessSnackBar(context, 'Please check your inbox');
        } else if (state is ResetEmailFailure) {
          showFailureSnackBar(context, state.errMassage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Icon(Icons.question_mark_outlined),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter the email address with your account and we\'ll send and email with confirmation to reset your password',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                prefix: Icon(Icons.email_outlined),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else {
                    return validateEmail(value);
                  }
                },
                controller: resetEmailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Email Address',
                labelText: 'Email Address',
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Send Email',
                ontap: () {
                  BlocProvider.of<AuthCubit>(context).resetPasswordWithEmail(
                      email: resetEmailController.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
