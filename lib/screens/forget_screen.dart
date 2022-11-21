import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/widgets/alert_dialog.dart';
import 'package:todo_list/widgets/material_button.dart';

import '../constants/colors.dart';
import '../models/users_data.dart';
import '../widgets/logo_icon.dart';
import 'onboard_screen.dart';

class ForgetScreen extends StatelessWidget {
  static const String id = 'ForgetScreen';
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(ColorX.redWhite),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const LogoIcon(),
            const Center(
              child: Text(
                'The user has already been initialized. If you want to\ncreate a new user you need to delete the previous user',
                style: TextStyle(
                  color: Color(ColorX.red),
                  fontSize: 16.0,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Button(
                sizeHeight: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 1.2,
                text: 'Delete',
                onTap: Platform.isAndroid
                    ? () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              getAccountDeleteAlert(context),
                        )
                    : () => showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) =>
                              getAccountDeleteAlert(context),
                        ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAccountDeleteAlert(context) {
    return AlertDialogLocal(
      title: 'Delete',
      content: 'Are you sure you want to delete..?',
      onTap: () {
        Provider.of<UserData>(context, listen: false).removeEmailPassword();
        Provider.of<UserData>(context, listen: false).deleteList();
        Navigator.pushReplacementNamed(context, OnBoardScreen.id);
      },
      buttonText: 'Delete',
    );
  }
}
