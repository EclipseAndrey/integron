import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status) {
    case "Выполнено":
      return Color.fromRGBO(141, 205, 224, 1);
      break;
    case "Отменено":
      return Colors.redAccent;
      break;
    case "Ожидание":
      return Color.fromRGBO(209, 211, 215, 1);
      break;
  }

}
