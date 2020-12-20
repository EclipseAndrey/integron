class Filter {
  static get all => All;
  static get payToken => PayToken();
  static get tokenSale => TokenSale();
  static get transferTokens => TransferTokens();
  static get exchangeTokens => ExchangeTokens();
  static get delegate => Delegate();
  static get payProduct => PayProduct();
  static get payService => PayService();
  String get name => "All";
}

class All extends Filter{
  @override
  String get name => "All";
}

class PayToken extends Filter{
  @override
  String get name => "PayToken";
}
class TokenSale extends Filter{
  @override
  String get name => "TokenSale";
}
class TransferTokens extends Filter{
  @override
  String get name => "TransferTokens";
}
class ExchangeTokens extends Filter{
  @override
  String get name => "ExchangeTokens";
}
class Delegate extends Filter{
  @override
  String get name => "Delegate";
}
class PayProduct extends Filter{
  @override
  String get name => "PayProduct";
}
class PayService extends Filter{
  @override
  String get name => "PayService";
}


