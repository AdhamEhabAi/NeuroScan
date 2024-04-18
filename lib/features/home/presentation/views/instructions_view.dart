import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/home/presentation/views/widgets/instruction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructionsView extends StatelessWidget {
  const InstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
        ),
        title: const Text(
          'Instructions',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          ImageIcon(
            AssetImage(kLogo),
            color: Colors.white,
            size: 100,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const InstructionWiddget(
                img: 'assets/images/number-1.png',
                head: 'Authentication',
                text:
                    'You can authenticate either by entering your email and password or by using your Google account.'),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const InstructionWiddget(
                img: 'assets/images/number-2.png',
                head: 'Choose Disease',
                text:
                    'Select from the available options to diagnose Alzheimer\'s, brain tumor, or autism.'),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const InstructionWiddget(
                img: 'assets/images/number-3.png',
                head: 'Analysis',
                text:
                'At this point, we are entering the image analysis phase to determine the presence of the disease'),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const InstructionWiddget(
                img: 'assets/images/number-4.png',
                head: 'Result',
                text:
                'Finally, let\'s proceed to the result stage where we\'ll provide insights into the diagnosis.'),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
