import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Autism/presentation/manager/autism_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeSliderWidget extends StatefulWidget {
  const AgeSliderWidget({super.key, required this.age});
  final double age;

  @override
  State<AgeSliderWidget> createState() => _AgeSliderWidgetState();
}

class _AgeSliderWidgetState extends State<AgeSliderWidget> {
  late double age = 20;
  @override
  void initState() {
    super.initState();

    age = widget.age;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Age',
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(
                age.round().toString(),
                style: const TextStyle(
                    fontSize: 20
                ),
              )),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Slider(
          activeColor: kSecondaryColor,
          value: age,
          inactiveColor: Colors.grey,
          max: 90,
          min: 0,
          label: age.round().toString(),
          onChanged: (value) {
            setState(() {
              age = value;
            });
            BlocProvider.of<AutismCubit>(context).setPatientAge(patientAge: age);
          },
        ),
      ],
    );
  }
}