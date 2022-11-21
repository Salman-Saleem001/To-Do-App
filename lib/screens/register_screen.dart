import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/app_bar.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/models/users_data.dart';
import 'package:todo_list/screens/forget_screen.dart';
import 'package:todo_list/screens/to_do.dart';
import 'package:todo_list/widgets/material_button.dart';

import '../constants/sized_box.dart';
import '../constants/toast_function.dart';
import '../constants/validation.dart';
import '../models/account_data.dart';
import '../widgets/logo_icon.dart';
import '../widgets/text_field_widget.dart';

class RegisterScreen extends HookWidget {
  static const String id = 'RegisterScreen';
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
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
            title: 'Register',
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
                  height: sizeHeight / 30,
                ),
                const LogoIcon(),
                SizedBox(
                  height: sizeHeight / 30,
                ),
                TextFieldWidget(
                  controller: nameController,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "This field must be filled ";
                    }
                    return null;
                  },
                  sizeHeight: sizeHeight,
                  iconData: Icons.account_circle,
                  hint: 'Enter Your Name',
                ),
                getSizedBox(sizeHeight),
                TextFieldWidget(
                  controller: emailController,
                  sizeHeight: sizeHeight,
                  iconData: Icons.email,
                  hint: 'Email',
                  validate: validateEmail,
                ),
                getSizedBox(sizeHeight),
                TextFieldWidget(
                  validate: validatePassword,
                  controller: passwordController,
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
                    text: 'Register',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (user!.email != null && user!.password != null) {
                          getToast("The user has Already been set");
                          Navigator.pushNamed(context, ForgetScreen.id);
                        } else {
                          Provider.of<UserData>(context, listen: false)
                              .setAccountDetails(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  true);
                          emailController.clear();
                          nameController.clear();
                          passwordController.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ToDoList.id, (route) => false);
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
