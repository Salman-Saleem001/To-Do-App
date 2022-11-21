import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

import '../constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.sizeHeight,
    required this.iconData,
    required this.hint,
    this.obscure = false,
    this.controller,
    this.validate,
    this.keyboardType = TextInputType.text,
  });

  final double sizeHeight;
  final IconData iconData;
  final String hint;
  final bool? obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      showCursor: true,
      minLines:
          keyboardType == TextInputType.multiline ? sizeHeight ~/ 700 : null,
      maxLines: keyboardType == TextInputType.multiline ? null : 1,
      keyboardType: keyboardType,
      validator: validate,
      controller: controller!,
      obscureText: obscure!,
      style: const TextStyle(
          color: Color(ColorX.primary),
          fontWeight: FontWeight.w600,
          fontSize: 14.0),
      cursorColor: Colors.black,
      cursorHeight: 20.0,
      cursorRadius: const Radius.circular(15.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            top: keyboardType == TextInputType.text ? 10.0 : 5.0, right: 10.0),
        prefixIcon: Icon(
          iconData,
          size: 15.0,
        ),
        prefixIconConstraints:
            const BoxConstraints.tightFor(height: 15, width: 30),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: kTextFieldStyle,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
          gapPadding: 0.0,
        ),
      ),
    );
  }
}
