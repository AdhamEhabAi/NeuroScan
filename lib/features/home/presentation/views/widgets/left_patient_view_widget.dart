import 'package:animation/features/home/presentation/views/widgets/advice_widget.dart';
import 'package:flutter/material.dart';

class LeftPatientViewWidget extends StatelessWidget {
  const LeftPatientViewWidget({super.key, required this.disease});
  final String disease;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xffD3E7EE).withOpacity(.6),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'DETAILED DIAGNOSIS',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ImageIcon(AssetImage('assets/images/full-stop.png')),
                      Text('${disease}',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20), // Space between sections
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ADVICES',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AdviceWidget(
                    img: 'assets/images/number-1.png',
                    text:
                    'Simple tasks and hobbies can maintain engagement.',
                    head: 'Encourage Activities',
                  ),
                  AdviceWidget(
                    img: 'assets/images/number-2.png',
                    text:
                    'Alzheimer\'s can be frustrating; patience is key.',
                    head: 'Stay Patient',
                  ),
                  AdviceWidget(
                    img: 'assets/images/number-3.png',
                    text:
                    'Consistent schedules reduce confusion.',
                    head: 'Set a Routine',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}