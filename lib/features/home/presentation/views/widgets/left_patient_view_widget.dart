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
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                        Text(
                          '${disease}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20), // Space between sections
                if (disease == 'Tumor')
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
                        text: 'Follow medical advice and treatment plans.',
                        head: 'Stick to Treatment',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-2.png',
                        text: 'Monitor and report changes to your doctor.',
                        head: 'Watch for Symptoms',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-3.png',
                        text: 'Get plenty of sleep and eat a balanced diet.',
                        head: 'Rest and Eat Well',
                      ),
                    ],
                  )
                else if (disease == 'Alzheimer')
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
                        text: 'Simple tasks and hobbies can maintain engagement.',
                        head: 'Encourage Activities',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-2.png',
                        text: 'Alzheimer\'s can be frustrating; patience is key.',
                        head: 'Stay Patient',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-3.png',
                        text: 'Consistent schedules reduce confusion.',
                        head: 'Set a Routine',
                      ),
                    ],
                  )
                else if (disease == 'Stroke')
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
                            'If you suspect a stroke, call emergency services right away.',
                        head: 'Seek Immediate Help',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-2.png',
                        text: 'Follow therapy and rehab programs for recovery.',
                        head: 'Commit to Rehabilitation',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-3.png',
                        text:
                            'Manage blood pressure and cholesterol',
                        head: 'Control Risk Factors',
                      ),
                    ],
                  )
                else if (disease == 'Autism')
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
                        text: 'Visual cues and aids support understanding.',
                        head: 'Use Visual Communication',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-2.png',
                        text: ' Start with small, comfortable settings.',
                        head: 'Encourage Social Interaction',
                      ),
                      AdviceWidget(
                        img: 'assets/images/number-3.png',
                        text:
                            'Adapt education and activities to individual needs.',
                        head: 'Personalize Learning',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
