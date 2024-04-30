import 'dart:async';
import 'package:animation/features/splash_and_getStarted/presentation/views/get_started.dart';
import 'package:animation/features/splash_and_getStarted/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAll(const GetStartedView(), transition: Transition.fadeIn,duration: const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: kPrimaryColor,
      body: SplashViewBody(),
    );
  }
}

