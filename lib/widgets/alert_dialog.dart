import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

class AlertDialogLocal extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTap;
  final String buttonText;
  const AlertDialogLocal(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(title),
            titleTextStyle: const TextStyle(color: Color(ColorX.red)),
            content: Text(content),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(buttonText),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(buttonText),
              ),
            ],
          );
  }
}
