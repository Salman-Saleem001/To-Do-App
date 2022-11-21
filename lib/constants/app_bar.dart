import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/screens/to_do.dart';

AppBar buildAppBar(
    {required String title,
    required BuildContext context,
    int color = ColorX.primary,
    bool leading = true}) {
  return AppBar(
    backgroundColor: const Color(ColorX.redWhite),
    automaticallyImplyLeading: false,
    leading: leading
        ? Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ToDoList.id);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(ColorX.primary),
              ),
            ),
          )
        : null,
    title: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: Color(color),
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
    ),
    centerTitle: true,
    elevation: 0.0,
    shape: Border(
      bottom: BorderSide(
        width: 1.5,
        color: Colors.grey.shade400,
      ),
    ),
  );
}
