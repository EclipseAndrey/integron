import 'package:flutter/material.dart';


import 'ContainerButtons.dart';
import 'StartCartsWidget.dart';

Widget StartWindow(BuildContext context) {
  Color cBackground = Color.fromRGBO(250, 250, 250, 1);
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        StartsCarts(context),
        containerButtons(context),
      ],
    ),
  );
}
