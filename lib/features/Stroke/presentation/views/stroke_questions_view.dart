import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/features/Stroke/data/questions_data/question_data.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:animation/features/Stroke/presentation/views/widgets/stoke_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;

class StrokeQuestionsView extends StatelessWidget {
  const StrokeQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StrokeCubit, StrokeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: kPrimaryColor,
            title: const Text(
              'Question\'s',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${BlocProvider.of<StrokeCubit>(context).currentQuestionIndex + 1}/${stokeQuestions.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24),
                ),
                QuestionWidget(
                    currentQuestionIndex: BlocProvider.of<StrokeCubit>(context)
                        .currentQuestionIndex),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stokeQuestions[BlocProvider.of<StrokeCubit>(context)
                          .currentQuestionIndex]
                      .answers
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CustomButton(
                        ontap: () {
                          BlocProvider.of<StrokeCubit>(context)
                              .setSelectedAnswer(
                                  answer: stokeQuestions[
                                          BlocProvider.of<StrokeCubit>(context)
                                              .currentQuestionIndex]
                                      .answers[index]);
                        },
                        text: stokeQuestions[BlocProvider.of<StrokeCubit>(context)
                                .currentQuestionIndex]
                            .answers[index],
                        backGroundColor: BlocProvider.of<StrokeCubit>(context)
                                    .selectedAnswer ==
                            stokeQuestions[BlocProvider.of<StrokeCubit>(context)
                                        .currentQuestionIndex]
                                    .answers[index]
                            ? kSecondryColor
                            : Colors.white,
                        textColor: BlocProvider.of<StrokeCubit>(context)
                                    .selectedAnswer ==
                            stokeQuestions[BlocProvider.of<StrokeCubit>(context)
                                    .currentQuestionIndex].answers[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  },
                ),
                CustomButton(
                  ontap: () {
                    // Check if the state is NoAnswerSelected
                    if (state is NoAnswerSelected) {
                      showHintSnackBar(context, 'No answer is selected');

                    }else {
                      // If an answer is selected, proceed to the next question
                      dynamic answerSelected =
                          BlocProvider.of<StrokeCubit>(context).selectedAnswer;
                      // Proceed with the next action
                      BlocProvider.of<StrokeCubit>(context)
                          .nextOnPressed(answerSelected: answerSelected);
                    }
                  },
                  text: 'Next',
                  backGroundColor: kSecondryColor,
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
