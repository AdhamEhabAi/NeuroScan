import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/widgets/custom_button.dart';
import 'package:animation/core/widgets/show_failure_snack_bar.dart';
import 'package:animation/core/widgets/show_hint_snack_bar.dart';
import 'package:animation/core/widgets/show_success_snack_bar.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:animation/features/Stroke/presentation/views/stroke_result_view.dart';
import 'package:animation/features/Stroke/presentation/views/widgets/stroke_image_upload_widget.dart';
import 'package:animation/features/Stroke/presentation/views/widgets/stroke_uploaded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get.dart' as trans;

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StrokeCubit, StrokeState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          showSuccessSnackBar(context, 'Image Upload Success');
        } else if (state is ImageUploadField) {
          showFailureSnackBar(context, state.errMassage);
        } else if (state is ImageRemoveSuccess) {
          showSuccessSnackBar(context, 'Image Remove Success');
        }
        if (state is PredictionSuccess) {
          showSuccessSnackBar(context, 'Prediction Success');
          trans.Get.off(StrokeResultView(result: BlocProvider.of<StrokeCubit>(context).result),transition: trans.Transition.rightToLeft);
        }else if(state is PredictionField){
          showFailureSnackBar(context, state.errMassage);

        }
      },
      builder: (context, state) {
        var selectedImage = BlocProvider.of<StrokeCubit>(context).selectedImage;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: kPrimaryColor,
            title: const Text(
              'Image Prediction',
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
          body: Center(
            child: ModalProgressHUD(
              inAsyncCall: state is ImageUploadLoading ||state is PredictionLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Now insert the Image',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        selectedImage != null
                            ? IconButton(
                                onPressed: () {
                                  BlocProvider.of<StrokeCubit>(context)
                                      .removeImage();
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              )
                            : Container(),
                      ],
                    ),

                    selectedImage != null
                        ? StrokeUploadedImage(
                            selectedImage: selectedImage,
                          )
                        : ImageUploadWidget(onTab: () {
                            BlocProvider.of<StrokeCubit>(context)
                                .pickImageFromGallery();
                          }),

                    const Text(
                      'Press the button and please wait for your result',
                      style: TextStyle(fontSize: 20, ),
                    ),

                    CustomButton(
                      backGroundColor: kSecondaryColor,
                        text: 'Result',
                        ontap: () {
                          if (BlocProvider.of<StrokeCubit>(context).selectedImage != null) {
                            BlocProvider.of<StrokeCubit>(context).getPredictionResult();
                          } else {
                            showHintSnackBar(context, 'Please Enter An Image');
                          }
                        }),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
