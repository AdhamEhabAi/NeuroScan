import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({super.key, required this.onTab});
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: DottedBorder(
        strokeWidth: 2,
        child: const SizedBox(
          width: double.infinity,
          height: 250,
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Press here to get Image from gallery',
              ),
              SizedBox(height: 20,),
              ImageIcon(
                AssetImage('assets/images/UploadImage.png'),
                size: 40,
              ),
            ],
          )),
        ),
      ),
    );
  }
}