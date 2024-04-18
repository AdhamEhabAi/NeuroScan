import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';

class SexSquareWidget extends StatelessWidget {
  const SexSquareWidget({super.key, required this.img, required this.gender, required this.ontap, required this.isMale});
  final String img;
  final String gender;
  final void Function() ontap;
  final bool isMale;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2.7,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  color: isMale ? kSecondryColor : Colors.grey.withOpacity(.3), width: 2),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      img,
                      width: 50,
                      color: isMale ? kSecondryColor: Colors.black,
                    ),
                    Text(gender,style: TextStyle(
                      color: isMale ? kSecondryColor : Colors.black,
                    ),),
                  ],
                )),
          ),
          isMale ?
          const Positioned(
            right: 4,
            top: 4,
            child: Icon(Icons.check_circle,color: kSecondryColor,),
          ) : Container(),
        ],
      ),
    );
  }
}