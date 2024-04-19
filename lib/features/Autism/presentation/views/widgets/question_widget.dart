import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Autism/data/questions_data/question_data.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.currentQuestionIndex});
  final int currentQuestionIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kSecondryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(questions[currentQuestionIndex].question,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18
          ),),
      )),
    );
  }
}
