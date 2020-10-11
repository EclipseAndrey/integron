import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyText extends StatelessWidget {

  Widget child;
  String copyText = "";
  String message = "Копировать";

  CopyText({@required this.child,@required this.copyText, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: new GestureDetector(
        child: new Tooltip(preferBelow: false,
            message: message, child: child),
        onTap: () {
          Clipboard.setData(ClipboardData(text: copyText));
        },
      ),
    );
  }
}