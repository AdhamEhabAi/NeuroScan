import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/splash_and_getStarted/presentation/views/widgets/get_started_animation.dart';
import 'package:animation/features/authentication/presentation/views/login_view.dart';
import 'package:animation/features/authentication/presentation/views/register_view.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome to NeuroScan: AI-Powered Insights for a Healthier Brain.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                GetStartedAnimation(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Login',
              ontap: () {
                Get.to(LoginPage(),transition: Transition.leftToRight,duration: const Duration(milliseconds: 1000));
              },
              backGroundColor: Colors.white,
              textColor: kPrimaryColor,
            ),
            CustomButton(
              text: 'Sign Up',
              ontap: () {
                Get.to( RegisterPage(),
                    transition: Transition.rightToLeft,duration: const Duration(milliseconds: 1000));
              },
            )
          ],
        ),
      ),
    );
  }
}

