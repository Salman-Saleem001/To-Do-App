import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/account_data.dart';

import '../constants/toast_function.dart';

class UserData extends ChangeNotifier {
  late List<String> _todoList = [];
  late List<String> _messageImportance = [];
  late List<String> _messageTime = [];
  final AccountData _accountData = AccountData();
  void setAccountDetails(
      String name, String email, String password, bool signedIn) async {
    final user = AccountData(
        name: name, email: email, password: password, signedIn: signedIn);
    _accountData.setEmailPassword(accountData: user);
    notifyListeners();
  }

  void getDataOfList() async {
    try {
      final pref = await SharedPreferences.getInstance();
      _todoList = pref.getStringList('todo')!;
      _messageImportance = pref.getStringList('importance')!;
      _messageTime = pref.getStringList('messageTime')!;
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  Future<AccountData?> getData() async {
    try {
      final user = await _accountData.getEmailPassword();
      return user;
    } catch (e) {
      return null;
    }
  }

  void removeEmailPassword() async {
    {
      bool check = await _accountData.removeEmailPassword();
      if (check) {
        getToast('User Deleted');
        notifyListeners();
      }
    }
  }

  void setToDo(
      {required String todo,
      required String importance,
      required String time}) async {
    _todoList.add(todo);
    _messageImportance.add(importance);
    _messageTime.add(time);
    try {
      final pref = await SharedPreferences.getInstance();
      pref.setStringList('todo', _todoList);
      pref.setStringList('importance', _messageImportance);
      pref.setStringList('messageTime', _messageTime);
      notifyListeners();
    } catch (e) {
      getToast('  Unable to add new data  ');
    }
  }

  List<String?> getTodo() {
    return _todoList;
  }

  List<String?> getImportance() {
    return _messageImportance;
  }

  List<String?> getTime() {
    return _messageTime;
  }

  void deleteList() async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.remove('todo');
      pref.remove('importance');
      pref.remove('message');
      notifyListeners();
    } catch (e) {
      getToast('Unable to delete Data');
    }
  }

  void deleteAtIndex(int index) async {
    _todoList.removeAt(index);
    _messageImportance.removeAt(index);
    _messageTime.removeAt(index);
    try {
      final pref = await SharedPreferences.getInstance();
      pref.remove('todo');
      pref.remove('importance');
      pref.remove('message');
      pref.setStringList('todo', _todoList);
      pref.setStringList('importance', _messageImportance);
      pref.setStringList('messageTime', _messageTime);
      notifyListeners();
    } catch (e) {
      getToast('Unable to delete Data');
    }
  }
}
