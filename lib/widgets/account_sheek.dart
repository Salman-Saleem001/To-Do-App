import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/sized_box.dart';
import 'package:todo_list/models/users_data.dart';
import 'package:todo_list/screens/onboard_screen.dart';
import 'package:todo_list/widgets/GetTile.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../models/account_data.dart';
import 'alert_dialog.dart';

class AccountDetails extends HookWidget {
  const AccountDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final user = useState(AccountData());
    useEffect(() {
      Future<void>.microtask(() async {
        user.value =
            (await Provider.of<UserData>(context, listen: false).getData())!;
      });
      return null;
    }, [user]);
    return user.value.email == null
        ? const SizedBox.expand()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: sizeHeight / 10,
              ),
              CircleAvatar(
                backgroundColor:
                    Color(getCharacterColor(user.value.name!.toUpperCase())),
                radius: 50.0,
                child: Text(
                  user.value.name![0].toUpperCase(),
                  style: const TextStyle(
                    color: Color(ColorX.white),
                    fontSize: 60.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: sizeHeight / 30,
              ),
              Text(
                user.value.name!,
                style: kTextFieldStyle,
              ),
              SizedBox(
                height: sizeHeight / 130,
              ),
              Text(
                user.value.email!,
                style: kTextFieldStyle,
              ),
              getSizedBox(sizeHeight),
              GetTile(
                iconData: Icons.no_accounts_rounded,
                title: 'Delete account',
                onPressed: Platform.isAndroid
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
              GetTile(
                iconData: Icons.logout,
                title: 'Logout',
                onPressed: Platform.isAndroid
                    ? () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              getLogoutAlert(context, user),
                        )
                    : () => showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) =>
                              getLogoutAlert(context, user),
                        ),
              ),
            ],
          );
  }

  getAccountDeleteAlert(context) {
    return AlertDialogLocal(
      title: 'Delete',
      content: 'Are you Sure you want to delete..?',
      onTap: () {
        Provider.of<UserData>(context, listen: false).removeEmailPassword();
        Provider.of<UserData>(context, listen: false).deleteList();
        Navigator.pushReplacementNamed(context, OnBoardScreen.id);
      },
      buttonText: 'Delete',
    );
  }

  getLogoutAlert(context, user) {
    return AlertDialogLocal(
      title: 'Logout',
      content: 'Are you Sure you want to Logout..?',
      onTap: () {
        Provider.of<UserData>(context, listen: false).setAccountDetails(
            user.value.name!, user.value.email!, user.value.password!, false);
        Navigator.pushReplacementNamed(context, OnBoardScreen.id);
      },
      buttonText: 'Logout',
    );
  }
}
