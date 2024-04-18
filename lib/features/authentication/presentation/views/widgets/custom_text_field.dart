import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.controller,
      this.validator,
      super.key,
      this.hintText,
      this.prefix,
      this.labelText,
      this.onChanged,
      this.obsecureText = false, required this.textInputType});
  String? labelText;
  String? hintText;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  Widget? prefix;
  bool obsecureText;
  TextEditingController? controller = TextEditingController();
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        keyboardType: textInputType,
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: kPrimaryColor),
          prefixIcon: prefix,
          prefixIconColor: kPrimaryColor,
        ),
      ),
    );
  }
}
