import 'package:flutter/material.dart';

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height); // Move to the bottom-left corner
    path.lineTo(0, size.height * 0.75); // Draw a line to the top-left corner with a slight padding
    path.quadraticBezierTo(
      size.width * 0.25, // Control point X for the first curve
      size.height * 0.5, // Control point Y for the first curve
      size.width * 0.5, // End point X for the first curve
      size.height * 0.75, // End point Y for the first curve
    ); // Draw a quadratic bezier curve to create the circular effect
    path.quadraticBezierTo(
      size.width * 0.75, // Control point X for the second curve
      size.height * 1.0, // Control point Y for the second curve
      size.width, // End point X for the second curve
      size.height * 0.75, // End point Y for the second curve
    ); // Draw a quadratic bezier curve to create the circular effect
    path.lineTo(size.width, size.height); // Draw a line to the bottom-right corner
    path.close(); // Close the path to complete the clipping
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
