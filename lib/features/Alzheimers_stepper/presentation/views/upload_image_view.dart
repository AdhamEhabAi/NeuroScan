import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/manager/Alzheimer_stepper_cubit.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/views/widgets/alzheimer_uploaded_image.dart';
import 'package:animation/features/Alzheimers_stepper/presentation/views/widgets/image_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlzheimerStepperCubit, AlzheimerStepperState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image Upload Success')),
          );
        } else if (state is ImageUploadField) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMassage)),
          );
        } else if (state is ImageRemoveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image Remove Success')),
          );
        }
      },
      builder: (context, state) {
        var selectedImage =
            BlocProvider.of<AlzheimerStepperCubit>(context).selectedImage;
        return Center(
          child: ModalProgressHUD(
            inAsyncCall: state is ImageUploadLoading,
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
                              BlocProvider.of<AlzheimerStepperCubit>(context)
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
                    ? AlzheimerUploadedImage(selectedImage: selectedImage,)
                    : ImageUploadWidget(onTab: () {
                        BlocProvider.of<AlzheimerStepperCubit>(context)
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
                          if (selectedImage != null) {
                            BlocProvider.of<AlzheimerStepperCubit>(context)
                                .increaseStepper();
                          }else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please Enter An Image')),
                            );
                          }
                        }
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Cancel',
                  backGroundColor: kSecondryColor,
                  ontap: () {
                    BlocProvider.of<AlzheimerStepperCubit>(context)
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
