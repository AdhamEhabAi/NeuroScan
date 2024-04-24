import 'dart:io';

import 'package:flutter/material.dart';

class StrokeUploadedImage extends StatelessWidget {
  const StrokeUploadedImage({super.key, required this.selectedImage});
  final File selectedImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(selectedImage),fit: BoxFit.fill)
      ),
    );
  }
}