import 'package:flutter/material.dart';

class PatientResultWidget extends StatelessWidget {
  const PatientResultWidget({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),),
        const SizedBox(height: 15,),
        Text(value,style: const TextStyle(fontSize: 18,),),
        const SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
          ),
        ),
      ],
    );
  }
}
