import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WidgetVariables extends StatelessWidget with PreferredSizeWidget {
  final Function openAddNewTransaction;

  const WidgetVariables(this.openAddNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => openAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => openAddNewTransaction(context),
              ),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
