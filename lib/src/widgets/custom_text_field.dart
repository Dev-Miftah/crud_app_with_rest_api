import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextField({super.key, required this.controller, required this.validator, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kErrorColor
          ),
            borderRadius: BorderRadius.circular(15),
        ),

      ),
    );
  }
}
