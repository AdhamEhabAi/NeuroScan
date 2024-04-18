import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/tumor_stepper/presentation/manager/tumor_stepper_cubit.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TumorStepperView extends StatelessWidget {
  const TumorStepperView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TumorStepperCubit, TumorStepperState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: const Text(
                'Brain Tumor Check',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
            body: CustomStepper(
                currentStep:
                    BlocProvider.of<TumorStepperCubit>(context).currentStep),
          ),
        );
      },
    );
  }
}
