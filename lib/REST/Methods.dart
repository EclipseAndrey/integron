part of 'Api.dart';


class Methods{
 static _UserMethods      get user      => _UserMethods();
 static _BizMethods       get biz       => _BizMethods();
 static _ProductMethods   get product   => _ProductMethods();
 static _CategoryMethods  get category  => _CategoryMethods();
 static _OrderMethods     get order     => _OrderMethods();
 static _WalletMethods    get wallet    => _WalletMethods();
 static _AuthMethods      get auth      => _AuthMethods();
 static _SearchMethods    get search    => _SearchMethods();

}

class _UserMethods{
  String get setName => "renameuser";
  String get setPhoto => "setphoto";
  String get setAddress => "setaddress";
  String get setRole => "setrole";
}
class _BizMethods{
  String get setBizName => "setbizname";
  String get setBizDesc => "setbizdesc";
  String get setBizPhoto => "setbizphoto";
  String get getBusinesses => "getbiz";
}
class _ProductMethods{
  String get getItems => "items";
  String get getItem => "item";
  String get createProduct => "createitem";
  String get updateProduct => "updateitem";
  String get deleteProduct => "deleteitem";
  String get upOnly => "up";
  String get upFull => "upfull";
  String get hiddenOff => "hideitem";
  String get hiddenOn => "showitem";
  String get setFavorite => "setfavorite";
  String get deleteFavorite => "deletefavorite";
  String get getFavorites => "getfavorites";

}
class _CategoryMethods{
  String get getItems => "getitemcategory";
  String get getCategories => "getcategories";
}
class _OrderMethods{
  String get getOrders => "mypurchase";
  String get makeOrder => "makeorder";
  String get getOrdersBiz => "myorders";

}
class _WalletMethods{
  String get getBalance => "balance";
  String get getTxs => "history";
  String get sendDel => "transfer";
}

class _AuthMethods{
  String get checkCode => "checkcode";
  String get getCode => "getcode";
  String get checkToken => "checktoken";
  String get updateToken => "updatetoken";
}

class _SearchMethods{
  String get search => "search";
}

class _PopularMethods{}

class _CartMethods{}



