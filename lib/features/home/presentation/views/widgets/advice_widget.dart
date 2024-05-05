import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  const AdviceWidget(
      {super.key, required this.img, required this.head, required this.text});
  final String img;
  final String head;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageIcon(
              AssetImage(img),
              color: kSecondaryColor,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                head,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.grey,),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
