import 'package:qr_flutter/qr_flutter.dart';

QrImage getQr (String text, {double size}){
  return QrImage(
    data: text,
    version: QrVersions.auto,
    size: size??200.0,
  );
}