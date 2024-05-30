import 'dart:io';
import 'package:flutter/services.dart'; 
import 'package:flutter/material.dart';

class ComumTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isObscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const ComumTextFormField({super.key, 
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        obscureText: isObscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}



