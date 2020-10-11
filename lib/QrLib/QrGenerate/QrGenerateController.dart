import 'package:qr_flutter/qr_flutter.dart';

QrImage getQr (String text){
  return QrImage(
    data: text,
    version: QrVersions.auto,
    size: 200.0,
  );
}