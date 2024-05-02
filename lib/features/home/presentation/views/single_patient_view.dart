import 'package:animation/features/home/presentation/views/widgets/Right_Patient_view_widget.dart';
import 'package:animation/features/home/presentation/views/widgets/left_patient_view_widget.dart';
import 'package:animation/features/home/presentation/views/widgets/single_patient_header_widget.dart';
import 'package:flutter/material.dart';

class SinglePatientView extends StatelessWidget {
  const SinglePatientView({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SinglePatientHeaderWidget(
              result: data['result'],
              age: data['age'] ?? '',
              date: data['date'] ?? '',
              isMale: data['isMale'] ?? '',
              fName: data['fName'] ?? '',
              lName: data['lName'] ?? '',
              pNumber: data['number'] ?? '',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // This allows child to expand vertically
                  children: [
                    LeftPatientViewWidget(disease: data['disease'] ?? '',),
                    SizedBox(width: 20), // Space between columns
                    RightPatientViewWidget(disease: data['disease'] ?? '',),
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
