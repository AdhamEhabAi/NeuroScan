import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/Autism/data/questions_data/question_data.dart';
import 'package:animation/features/Autism/presentation/manager/autism_cubit.dart';
import 'package:animation/features/Autism/presentation/views/result_view.dart';
import 'package:animation/features/Autism/presentation/views/widgets/question_widget.dart';
import 'package:animation/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as trans;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutismCubit, AutismState>(
      listener: (context, state) {
        if (state is PredictionSuccess) {
          trans.Get.off(const ResultView());
          showSuccessSnackBar(context, 'Prediction Success');
          BlocProvider.of<AutismCubit>(context).reset();
        } else if (state is PredictionFailure) {
          showFailureSnackBar(context, state.errMassage);
          trans.Get.offAll(const HomeScreen());
          BlocProvider.of<AutismCubit>(context).reset();
        }
      },
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
                  BlocProvider.of<AutismCubit>(context).reset();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          body: ModalProgressHUD(
            inAsyncCall: state is PredictionLoading,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                      currentQuestionIndex:
                          BlocProvider.of<AutismCubit>(context)
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
                                            BlocProvider.of<AutismCubit>(
                                                    context)
                                                .currentQuestionIndex]
                                        .answers[index]);
                          },
                          text: questions[BlocProvider.of<AutismCubit>(context)
                                  .currentQuestionIndex]
                              .answers[index],
                          backGroundColor: BlocProvider.of<AutismCubit>(context)
                                      .selectedAnswer ==
                                  questions[
                                          BlocProvider.of<AutismCubit>(context)
                                              .currentQuestionIndex]
                                      .answers[index]
                              ? kSecondaryColor
                              : Colors.white,
                          textColor: BlocProvider.of<AutismCubit>(context)
                                      .selectedAnswer ==
                                  questions[
                                          BlocProvider.of<AutismCubit>(context)
                                              .currentQuestionIndex]
                                      .answers[index]
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
                      } else {
                        // If an answer is selected, proceed to the next question
                        dynamic answerSelected =
                            BlocProvider.of<AutismCubit>(context)
                                .selectedAnswer;
                        // Proceed with the next action
                        BlocProvider.of<AutismCubit>(context)
                            .nextOnPressed(answerSelected: answerSelected);
                      }
                    },
                    text: 'Next',
                    backGroundColor: kSecondaryColor,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
