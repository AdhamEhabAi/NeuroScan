import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/tumor_stepper/presentation/manager/tumor_stepper_cubit.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/image_upload_widget.dart';
import 'package:animation/features/tumor_stepper/presentation/views/widgets/tumor_uploaded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TumorStepperCubit, TumorStepperState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          showSuccessSnackBar(context, 'Image Upload Success');
        } else if (state is ImageUploadField) {
          showFailureSnackBar(context, state.errMassage);
        } else if (state is ImageRemoveSuccess) {
          showSuccessSnackBar(context, 'Image Remove Success');
        }
        if (state is PredictionSuccess) {
          BlocProvider.of<TumorStepperCubit>(context).increaseStepper();
          showSuccessSnackBar(context, 'Prediction Success');
        } else if (state is PredictionField) {
          showFailureSnackBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        var selectedImage =
            BlocProvider.of<TumorStepperCubit>(context).selectedImage;
        return Center(
          child: ModalProgressHUD(
            inAsyncCall: state is ImageUploadLoading || state is PredictionLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Now insert the Image',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    selectedImage != null
                        ? IconButton(
                            onPressed: () {
                              BlocProvider.of<TumorStepperCubit>(context)
                                  .removeImage();
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                selectedImage != null
                    ? TumorUploadedImage(
                        selectedImage: selectedImage,
                      )
                    : ImageUploadWidget(onTab: () {
                        BlocProvider.of<TumorStepperCubit>(context)
                            .pickImageFromGallery();
                      }),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Press Continue and please wait',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: 'Continue',
                    ontap: () {
                      if (BlocProvider.of<TumorStepperCubit>(context).selectedImage != null) {
                        BlocProvider.of<TumorStepperCubit>(context).getPredictionResult();

                      } else {
                        showHintSnackBar(context, 'Please Enter An Image');
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Cancel',
                  backGroundColor: kSecondryColor,
                  ontap: () {
                    BlocProvider.of<TumorStepperCubit>(context)
                        .decreaseStepper();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
