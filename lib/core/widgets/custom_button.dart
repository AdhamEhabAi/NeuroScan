import 'package:flutter/material.dart';

import '../utils/constants.dart';
class CustomButton extends StatelessWidget {
  CustomButton({this.textColor=Colors.white,this.backGroundColor=kPrimaryColor,this.ontap,required this.text,super.key});
  String? text;
  Color? textColor;
  Color? backGroundColor;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 7,
            ),
          ],
          color: backGroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(child: Text(text!,style: TextStyle(color: textColor,fontSize: 18),)),
      ),);

  }
}
