import 'package:animation/features/home/presentation/views/widgets/Patient_Image_widget.dart';
import 'package:animation/features/home/presentation/views/widgets/left_patient_view_widget.dart';
import 'package:animation/features/home/presentation/views/widgets/single_patient_header_widget.dart';
import 'package:flutter/material.dart';

class SinglePatientView extends StatelessWidget {
  const SinglePatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SinglePatientHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // This allows child to expand vertically
                  children: [
                    LeftPatientViewWidget(),
                    SizedBox(width: 20), // Space between columns
                    PatientImageWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

