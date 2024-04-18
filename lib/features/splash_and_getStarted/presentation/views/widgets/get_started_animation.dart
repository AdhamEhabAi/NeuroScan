import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GetStartedAnimation extends StatelessWidget {
  const GetStartedAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Lottie.asset(
          'assets/animations/getStartedAnimation.json'),
    );
  }
}
