import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PatientImageWidget extends StatelessWidget {
  const PatientImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xffD3E7EE).withOpacity(.6),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/undraw_doctors_p6aq.svg',
            fit: BoxFit.contain,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
