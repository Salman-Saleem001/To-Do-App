import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GetTile extends StatelessWidget {
  const GetTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final IconData iconData;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      iconColor: const Color(ColorX.grey),
      textColor: const Color(ColorX.primary),
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: const Border(
        bottom: BorderSide(color: Color(ColorX.grey), width: .5),
      ),
    );
  }
}
