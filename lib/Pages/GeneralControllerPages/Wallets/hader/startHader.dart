import 'package:flutter/material.dart';


import 'ContainerButtons.dart';
import 'StartCartsWidget.dart';


class StartWindow extends StatefulWidget {
  @override
  _StartWindowState createState() => _StartWindowState();
}

class _StartWindowState extends State<StartWindow> {
  @override
  Widget build(BuildContext context) {
    return  SliverList(
      delegate: SliverChildListDelegate(
        [
          StartCarts(),
          containerButtons(context),
        ],
      ),
    );
  }
}


