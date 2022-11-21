import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundColor: Color(ColorX.primary),
        radius: 30.0,
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
