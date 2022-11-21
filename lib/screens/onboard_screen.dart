import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/constants/sized_box.dart';
import 'package:todo_list/screens/register_screen.dart';
import 'package:todo_list/widgets/logo_icon.dart';
import 'package:todo_list/widgets/material_button.dart';

import 'login_screen.dart';

class OnBoardScreen extends StatelessWidget {
  static const String id = 'OnBoardScreen';
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(ColorX.dullWhite),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeHeight / 10,
            ),
            const LogoIcon(),
            const Text(
              'To Do List',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Color(ColorX.primary),
              ),
            ),
            SizedBox(
              height: sizeHeight / 3,
            ),
            Button(
              sizeHeight: sizeHeight,
              text: 'Register',
              width: sizeWidth / 2,
              onTap: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            ),
            getSizedBox(sizeHeight),
            Flexible(
              flex: 2,
              child: Button(
                sizeHeight: sizeHeight,
                text: 'Login',
                background: ColorX.white,
                width: sizeWidth / 2,
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
