import 'package:flutter/material.dart';

class JBMBTextField extends StatelessWidget {
  final bool obsecure;
  final String labelText;
  final String? hintText;
  final TextInputType textInputType;
  final TextEditingController? controller;

  const JBMBTextField({
    Key? key,
    required this.obsecure,
    required this.labelText,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecure,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      keyboardType: textInputType,
      controller: controller,
    );
  }
}