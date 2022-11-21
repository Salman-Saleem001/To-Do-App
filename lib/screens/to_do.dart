import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/app_bar.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/screens/create_task.dart';

import '../models/users_data.dart';
import '../widgets/ConsumerWidget.dart';
import '../widgets/account_sheek.dart';

class ToDoList extends HookWidget {
  static const String id = 'ToDoList';
  ToDoList({Key? key}) : super(key: key);
  final List<Widget> onTap = [const ConsumerWidget(), const AccountDetails()];
  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    useEffect(() {
      Future<void>.microtask(() async {
        Provider.of<UserData>(context, listen: false).getDataOfList();
      });
      return null;
    }, [UserData]);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CreateTask.id);
          },
          backgroundColor: const Color(ColorX.primary),
          child: const Icon(
            Icons.add,
            color: Color(ColorX.white),
          ),
        ),
        backgroundColor: const Color(ColorX.redWhite),
        appBar: buildAppBar(
            title: selectedIndex.value == 0 ? 'To Do List' : 'Account Details',
            context: context,
            leading: false,
            color: ColorX.orange),
        body: onTap[selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(ColorX.white)),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color(ColorX.white),
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: selectedIndex.value,
          selectedItemColor: const Color(ColorX.primary),
          unselectedItemColor: const Color(ColorX.grey),
          iconSize: 25,
          onTap: (index) {
            selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
