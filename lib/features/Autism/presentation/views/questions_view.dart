import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_snack_bar.dart';
import 'package:animation/features/Autism/data/questions_data/question_data.dart';
import 'package:animation/features/Autism/presentation/manager/autism_cubit.dart';
import 'package:animation/features/Autism/presentation/views/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutismCubit, AutismState>(
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
                  'Question ${BlocProvider.of<AutismCubit>(context).currentQuestionIndex + 1}/${questions.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24),
                ),
                QuestionWidget(
                    currentQuestionIndex: BlocProvider.of<AutismCubit>(context)
                        .currentQuestionIndex),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: questions[BlocProvider.of<AutismCubit>(context)
                          .currentQuestionIndex]
                      .answers
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CustomButton(
                        ontap: () {
                          BlocProvider.of<AutismCubit>(context)
                              .setSelectedAnswer(
                                  answer: questions[
                                          BlocProvider.of<AutismCubit>(context)
                                              .currentQuestionIndex]
                                      .answers[index]);
                        },
                        text: questions[BlocProvider.of<AutismCubit>(context)
                                .currentQuestionIndex]
                            .answers[index],
                        backGroundColor: BlocProvider.of<AutismCubit>(context)
                                    .selectedAnswer ==
                                questions[BlocProvider.of<AutismCubit>(context)
                                        .currentQuestionIndex]
                                    .answers[index]
                            ? kSecondryColor
                            : Colors.white,
                        textColor: BlocProvider.of<AutismCubit>(context)
                                    .selectedAnswer ==
                                questions[BlocProvider.of<AutismCubit>(context)
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text('No answer is selected'))));

                    }else {
                      // If an answer is selected, proceed to the next question
                      dynamic answerSelected =
                          BlocProvider.of<AutismCubit>(context).selectedAnswer;
                      // Proceed with the next action
                      BlocProvider.of<AutismCubit>(context)
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
