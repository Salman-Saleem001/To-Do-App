import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> getToast(String e) {
  return Fluttertoast.showToast(
      msg: e, webPosition: "centre", fontSize: 14.0, timeInSecForIosWeb: 3);
}
