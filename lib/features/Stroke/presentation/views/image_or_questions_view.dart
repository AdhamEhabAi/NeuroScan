import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Stroke/presentation/views/storke_upload_image_view.dart';
import 'package:animation/features/Stroke/presentation/views/stroke_questions_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as trans;

class ImageOrQuestionView extends StatelessWidget {
  const ImageOrQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Stroke Prediction',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              trans.Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kSecondryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'You prefer image or questions ?',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    trans.Get.to(UploadImageView(),
                        transition: trans.Transition.rightToLeft);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Image',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    trans.Get.to(StrokeQuestionsView(),
                        transition: trans.Transition.rightToLeft);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Questions',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.quiz,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
