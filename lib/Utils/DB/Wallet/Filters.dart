class Filter {
  static get all => All;
  static get tokenSale => TokenSale();
  static get transferTokens => TransferTokens();
  static get exchangeTokens => ExchangeTokens();
  static get delegate => Delegate();
  static get payProduct => PayProduct();
  static get payService => PayService();
}

class All extends Filter{}
class TokenSale extends Filter{}
class TransferTokens extends Filter{}
class ExchangeTokens extends Filter{}
class Delegate extends Filter{}
class PayProduct extends Filter{}
class PayService extends Filter{}


