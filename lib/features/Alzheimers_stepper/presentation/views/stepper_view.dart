import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/views/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../manager/Alzheimer_stepper_cubit.dart';

class AlzheimerStepperView extends StatelessWidget {
  const AlzheimerStepperView({super.key,});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlzheimerStepperCubit, AlzheimerStepperState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: const Text('Alzheimer\'s Check',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              centerTitle: true,
              leading: IconButton(onPressed: ()
              {
                Get.back();
              }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            ),
            body: CustomStepper(
                currentStep:
                    BlocProvider.of<AlzheimerStepperCubit>(context).currentStep),
          ),
        );
      },
    );
  }
}
