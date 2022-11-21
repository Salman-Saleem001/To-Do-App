import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.sizeHeight,
    this.background = ColorX.primary,
    required this.text,
    this.width = double.infinity,
    required this.onTap,
  }) : super(key: key);

  final double sizeHeight;
  final int? background;
  final String text;
  final double width;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: width,
      height: sizeHeight / 17,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Color(background!),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: background == ColorX.primary
              ? const Color(ColorX.white)
              : const Color(ColorX.primary),
        ),
      ),
    );
  }
}
