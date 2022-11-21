import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/models/account_data.dart';
import 'package:todo_list/screens/onboard_screen.dart';
import 'package:todo_list/screens/to_do.dart';

import '../models/users_data.dart';

class SplashScreenM extends HookWidget {
  static const String id = 'SplashScreen';
  const SplashScreenM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useState(AccountData());
    useEffect(() {
      Future<void>.microtask(() async {
        user.value =
            (await Provider.of<UserData>(context, listen: false).getData())!;
      });
      return null;
    }, [user]);
    return AnimatedSplashScreen(
      splash: const CircleAvatar(
        backgroundColor: Color(ColorX.primary),
        radius: 30.0,
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50.0,
        ),
      ),
      nextScreen: getNextScreen(user),
      centered: true,
      splashTransition: SplashTransition.sizeTransition,
      backgroundColor: const Color(ColorX.white),
    );
  }
}

Widget getNextScreen(user) {
  if (user.value.email != null && user.value.signedIn != false) {
    return ToDoList();
  } else {
    return const OnBoardScreen();
  }
}
