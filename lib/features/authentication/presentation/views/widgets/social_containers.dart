import 'package:flutter/material.dart';

class SocialContainers extends StatelessWidget {
  const SocialContainers({required this.imagePath, this.ontap, super.key});

  final String imagePath;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                fit: BoxFit.cover,
                imagePath,
                height: 25,
              ),
              const Text(
                'Login With Google',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              // const SizedBox(width: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
