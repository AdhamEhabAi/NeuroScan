import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';

class InstructionWiddget extends StatelessWidget {
  const InstructionWiddget({super.key, required this.img, required this.head, required this.text});
  final String img;
  final String head;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        ImageIcon(
          AssetImage(img),
          color: kSecondryColor,
          size: 40,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                head,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
