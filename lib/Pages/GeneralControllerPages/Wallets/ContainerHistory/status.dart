import 'package:flutter/material.dart';
import 'package:omega_qick/Utils/fun/statusColorWidget.dart';


Widget statusWidget(String status, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: statusColor(status),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
      child: Center(
          child: Text(status,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.white))),
    ),

  );
}
