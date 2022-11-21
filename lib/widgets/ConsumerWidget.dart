import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../models/users_data.dart';
import 'alert_dialog.dart';

class ConsumerWidget extends HookWidget {
  const ConsumerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return userData.getTodo().isNotEmpty
            ? ListView.builder(
                itemCount: userData.getTodo().length,
                itemBuilder: (BuildContext context, int index) {
                  int itemCount = userData.getTodo().length;
                  int reversedIndex = itemCount - 1 - index;
                  return ListTile(
                    onLongPress: Platform.isAndroid
                        ? () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  getDataDeleteAlert(context, index),
                            )
                        : () => showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) =>
                                  getDataDeleteAlert(context, index),
                            ),
                    style: ListTileStyle.drawer,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: const Border(
                      bottom: BorderSide(color: Color(ColorX.grey), width: .5),
                    ),
                    leading: const Icon(
                      Icons.check,
                      color: Colors.grey,
                      size: 12.0,
                    ),
                    title: Text(
                      userData.getTodo()[reversedIndex]!,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        color: Color(
                          getColor(userData.getImportance()[reversedIndex]!),
                        ),
                      ),
                    ),
                    trailing: Text(
                      getTime(userData.getTime()[reversedIndex]!),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            : const SizedBox.expand();
      },
    );
  }

  getDataDeleteAlert(context, int index) {
    return AlertDialogLocal(
      title: 'Delete ToDo',
      content: 'Are you Sure you want to delete..?',
      onTap: () {
        Provider.of<UserData>(context, listen: false).deleteAtIndex(index);
        Navigator.pop(context);
      },
      buttonText: 'Delete',
    );
  }
}
