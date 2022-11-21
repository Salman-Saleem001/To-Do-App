import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screens/to_do.dart';

import '../constants/app_bar.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../constants/toast_function.dart';
import '../constants/validation.dart';
import '../models/account_data.dart';
import '../models/users_data.dart';
import '../widgets/logo_icon.dart';
import '../widgets/material_button.dart';
import '../widgets/text_field_widget.dart';

class LoginScreen extends HookWidget {
  static const String id = 'LoginScreen';
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    AccountData? user = AccountData();
    useEffect(() {
      Future<void>.microtask(() async {
        user = await Provider.of<UserData>(context, listen: false).getData();
      });
      return null;
    }, [user]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(ColorX.redWhite),
        appBar: buildAppBar(
            title: 'Login',
            context: context,
            onTap: () {
              Navigator.pop(context);
            }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: sizeHeight / 20,
                ),
                const LogoIcon(),
                SizedBox(
                  height: sizeHeight / 20,
                ),
                TextFieldWidget(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validate: validateEmail,
                  sizeHeight: sizeHeight,
                  iconData: Icons.email,
                  hint: 'Email',
                ),
                getSizedBox(sizeHeight),
                TextFieldWidget(
                  controller: passwordController,
                  validate: validatePassword,
                  sizeHeight: sizeHeight,
                  iconData: Icons.lock,
                  hint: 'Password',
                  obscure: true,
                ),
                getSizedBox(sizeHeight),
                Flexible(
                  flex: 1,
                  child: Button(
                    sizeHeight: sizeHeight,
                    text: 'Login',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (emailController.text == user!.email &&
                            passwordController.text == user!.password &&
                            user!.signedIn == false) {
                          Provider.of<UserData>(context, listen: false)
                              .setAccountDetails(
                                  user!.name!,
                                  emailController.text,
                                  passwordController.text,
                                  true);
                          emailController.clear();
                          passwordController.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ToDoList.id, (route) => false);
                        } else if (user?.email == null &&
                            user?.password == null) {
                          getToast("No user has been initialized yet");
                        } else {
                          getToast('Either password or email is incorrect');
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
