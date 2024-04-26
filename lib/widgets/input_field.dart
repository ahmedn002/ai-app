import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final Color? fillColor;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor = AppColors.primaryText,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        fillColor: fillColor,
        filled: fillColor != null,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: _getInputBorder(context),
        enabledBorder: _getInputBorder(context),
        focusedBorder: _getInputBorder(context),
      ),
    );
  }

  InputBorder _getInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
    );
  }
}
