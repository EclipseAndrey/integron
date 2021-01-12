part of 'DraftDB.dart';

class DraftTable {
  static String get table => "Draft";
  static String get images => table + "images";
  static String get unit => table + "unit";
  static String get type => table + "type";
  static String get property => table + "property";
  static String get delivery => table + "delivery";
  static String get address => table + "address";
  static String get fullText => table + "fullText";
  static String get shortText => table + "shortText";
  static String get category => table + "category";
  static String get details => table + "details";
  static String get params => table + "params";
  static String get accountName => table + "accountName";
  static String get accountSecretKey => table + "accountSecretKey";
  static String get offerCode => table + "accountOfferCode";
  static String get name => table + "name";
  static String get price => table + "price";
}
//
// List<String> images,
// String unit,
// int type,
// List<Property> property,
// int delivery,
// String address,
// String fullText,
// String shortText,
// int category,
// List<String> details,
// List<Params> params,
// String accountName,
// String accountSecretKey,
// String offerCode,
// String name,
// double price,