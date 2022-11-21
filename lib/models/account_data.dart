import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class AccountData {
  String? name;
  String? email;
  String? password;
  bool? signedIn;
  AccountData({this.name, this.email, this.password, this.signedIn});

  void setEmailPassword({required AccountData accountData}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('name', accountData.name!);
    pref.setString('email', accountData.email!);
    pref.setString('password', accountData.password!);
    pref.setBool('signedIn', accountData.signedIn!);
  }

  //
  Future<AccountData?> getEmailPassword() async {
    final pref = await SharedPreferences.getInstance();
    return AccountData(
        name: pref.getString('name'),
        email: pref.getString('email'),
        password: pref.getString('password'),
        signedIn: pref.getBool('signedIn'));
  }

  Future<bool> removeEmailPassword() async {
    final pref = await SharedPreferences.getInstance();
    bool check = false;
    if (await pref.remove('name') &&
        await pref.remove('email') &&
        await pref.remove('password') &&
        await pref.remove('signedIn')) {
      check = true;
    }
    return check;
  }
}
