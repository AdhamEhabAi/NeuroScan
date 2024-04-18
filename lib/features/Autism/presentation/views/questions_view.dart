import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as trans;

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Question\'s',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
        ),
        leading: IconButton(onPressed: ()
        {
          trans.Get.back();
        },icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
    );
  }
}
