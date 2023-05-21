import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/app_bar.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/constants/sized_box.dart';
import 'package:todo_list/models/users_data.dart';
import 'package:todo_list/screens/to_do.dart';
import 'package:todo_list/widgets/material_button.dart';
import 'package:todo_list/widgets/text_field_widget.dart';

import '../constants/constants.dart';

class CreateTask extends HookWidget {
  static const String id = 'CreateTask';
  CreateTask({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> _createList() {
    return dropdownList
        .map(
          (map) => DropdownMenuItem<String>(
            value: map,
            child: Text(
              map,
              style: TextStyle(
                  color: Color(getColor(map)),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final dropdownValue = useState('!  Importance');
    final sizeHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(ColorX.redWhite),
        appBar: buildAppBar(
            title: 'Create list',
            context: context,
            leading: true,
            onTap: () {
              Navigator.pushReplacementNamed(context, ToDoList.id);
            },
            color: ColorX.orange),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                getSizedBox(sizeHeight),
                TextFieldWidget(
                  controller: controller,
                  validate: (val) {
                    if (val!.isEmpty && val.trim().isEmpty) {
                      return 'This field cannot be Empty';
                    }
                    return null;
                  },
                  sizeHeight: sizeHeight,
                  keyboardType: TextInputType.multiline,
                  iconData: Icons.list,
                  hint: 'Write your to do',
                ),
                getSizedBox(sizeHeight),
                Container(
                  height: sizeHeight / 18,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(ColorX.white),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(30.0),
                    items: _createList(),
                    onChanged: (newValue) {
                      dropdownValue.value = newValue.toString();
                    },
                    value: dropdownValue.value,
                    iconDisabledColor: Colors.grey.shade400,
                    iconEnabledColor: Colors.grey.shade400,
                  ),
                ),
                getSizedBox(sizeHeight),
                Button(
                  sizeHeight: sizeHeight,
                  text: 'Create',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (dropdownValue.value == '!  Importance') {
                        dropdownValue.value = dropdownList[2];
                      }
                      String timeStamp = DateTime.now().toIso8601String();
                      Provider.of<UserData>(context, listen: false).setToDo(
                          todo: controller.text,
                          importance: dropdownValue.value,
                          time: timeStamp);
                      Navigator.pop(context);
                    }
                  },
                  width: double.infinity / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
