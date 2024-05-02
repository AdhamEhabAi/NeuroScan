import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RightPatientViewWidget extends StatelessWidget {
  const RightPatientViewWidget({super.key, required this.disease});
  final String disease;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xffD3E7EE),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/undraw_doctors_p6aq.svg',
                fit: BoxFit.contain,
                height: 200,
              ),
              Text(
                'TESTS',
                style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  ImageIcon(AssetImage('assets/images/full-stop.png')),
                  if (disease == 'Alzheimer')
                    Text(
                      'MMSE',
                    )
                  else if (disease == 'Tumor')
                    Text(
                      'MRI',
                    )
                  else if (disease == 'Stroke')
                    Text(
                      'MRI',
                    )
                  else if (disease == 'Autism')
                    Text(
                      'M-CHAT',
                    ),
                ],
              ),
              Row(
                children: [
                  ImageIcon(AssetImage('assets/images/full-stop.png')),
                  if (disease == 'Alzheimer')
                    Text('MoCA')
                  else if (disease == 'Tumor')
                    Text(
                      'PET',
                    )
                  else if (disease == 'Stroke')
                    Text(
                      'CTA',
                    )
                  else if (disease == 'Autism')
                    Text(
                      'ASQ',
                    ),
                ],
              ),
              Row(
                children: [
                  ImageIcon(AssetImage('assets/images/full-stop.png')),
                  if (disease == 'Alzheimer')
                    Text('MRI')
                  else if (disease == 'Tumor')
                    Text(
                      'MRS',
                    )
                  else if (disease == 'Stroke')
                    Text(
                      'ECG/EKG',
                    )
                  else if (disease == 'Autism')
                    Text(
                      'ADOS',
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
