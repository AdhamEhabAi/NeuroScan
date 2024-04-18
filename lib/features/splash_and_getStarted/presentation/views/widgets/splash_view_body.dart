import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/splash.json'),
          const Text(
            'NeuroScan',
            style: TextStyle(
                fontSize: 30,
              fontWeight: FontWeight.bold

            ),
          ),
        ],
      ),
    );
  }
}
