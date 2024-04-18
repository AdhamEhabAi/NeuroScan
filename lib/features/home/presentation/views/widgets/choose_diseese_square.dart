import 'package:flutter/material.dart';

class ChooseDiseaseSquare extends StatelessWidget {
  const ChooseDiseaseSquare(
      {super.key,
        required this.txt,
        required this.img,
        required this.squareColor,
        required this.onTap});
  final String txt;
  final String img;
  final Color squareColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          color: squareColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(img, width: 60),
              Text(
                txt,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
