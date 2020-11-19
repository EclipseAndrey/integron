import 'package:flutter/material.dart';

Color statusColor(int status) {
  switch (status) {
    case 0:
      return Color.fromRGBO(141, 205, 224, 1);
      break;
    case 1:
      return Colors.redAccent;
      break;
    case 2:
      return Color.fromRGBO(209, 211, 215, 1);
      break;
  }

}
