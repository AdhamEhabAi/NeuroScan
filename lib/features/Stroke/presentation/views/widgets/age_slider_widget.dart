import 'package:animation/core/utils/constants.dart';
import 'package:animation/features/Stroke/presentation/manager/stroke_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StrokeAgeSliderWidget extends StatefulWidget {
  const StrokeAgeSliderWidget({super.key, required this.age});
  final double age;

  @override
  State<StrokeAgeSliderWidget> createState() => _StrokeAgeSliderWidgetState();
}

class _StrokeAgeSliderWidgetState extends State<StrokeAgeSliderWidget> {
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
            BlocProvider.of<StrokeCubit>(context).setPatientAge(patientAge: age);
          },
        ),
      ],
    );
  }
}