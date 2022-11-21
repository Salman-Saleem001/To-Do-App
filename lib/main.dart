import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/users_data.dart';
import 'package:todo_list/screens/SplashScreen.dart';
import 'package:todo_list/screens/create_task.dart';
import 'package:todo_list/screens/forget_screen.dart';
import 'package:todo_list/screens/login_screen.dart';
import 'package:todo_list/screens/onboard_screen.dart';
import 'package:todo_list/screens/register_screen.dart';
import 'package:todo_list/screens/to_do.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: ThemeData(
          backgroundColor: const Color(ColorX.dullWhite),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
          ),
        ),
        initialRoute: SplashScreenM.id,
        routes: {
          OnBoardScreen.id: (context) => const OnBoardScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          CreateTask.id: (context) => CreateTask(),
          ToDoList.id: (context) => ToDoList(),
          SplashScreenM.id: (context) => const SplashScreenM(),
          ForgetScreen.id: (context) => const ForgetScreen(),
        },
      ),
    );
  }
}
