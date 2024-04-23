import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/top_cliper.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/views/stepper_view.dart';
import 'package:animation/features/Autism/presentation/views/autism_patient_info_view.dart';
import 'package:animation/features/Stroke/presentation/views/image_or_questions_view.dart';
import 'package:animation/features/home/presentation/views/widgets/choose_diseese_square.dart';
import 'package:animation/features/home/presentation/views/widgets/home_view_drawer.dart';
import 'package:animation/features/tumor_stepper/presentation/views/stepper_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Neuro',
                    style: TextStyle(
                        color: kSecondryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  Text(
                    'Scan',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
              Image.asset(kLogo, width: 70),
            ],
          ),
        ),
        drawer: const HomeViewDrawer(),
        body: Stack(
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Empower ',
                        style: TextStyle(
                            color: kSecondryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mental Wellness.',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Pick your focus: Alzheimer\'s, autism, stroke, or brain tumor, in our health app.',
                      style: TextStyle(
                          fontSize: 20, color: Colors.grey.withOpacity(.7)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Choose disease',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 120,
                          child: CustomScrollView(
                            clipBehavior: Clip.none,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            slivers: [
                              SliverToBoxAdapter(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ChooseDiseaseSquare(
                                        onTap: () {
                                          Get.to(const TumorStepperView(),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        img: 'assets/images/tumor.png',
                                        squareColor: kSecondryColor,
                                        txt: 'Brain Tumor'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ChooseDiseaseSquare(
                                        onTap: () {
                                          Get.to(const AlzheimerStepperView(),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        img: 'assets/images/alzheimer.png',
                                        squareColor: kPrimaryColor,
                                        txt: 'Alzheimer'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ChooseDiseaseSquare(
                                        onTap: () {
                                          Get.to(const AutismPatientInfoView(),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        img: 'assets/images/autism.png',
                                        squareColor: Colors.cyan,
                                        txt: 'Autism'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ChooseDiseaseSquare(
                                        onTap: () {
                                          Get.to(const ImageOrQuestionView(),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        img: 'assets/images/brain.png',
                                        squareColor: Colors.redAccent,
                                        txt: 'Stroke'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: TopClipper(),
                child: Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
