class TxData {

  String log;
  String coin;
  String check;
  String coins;
  String proof;
  String title;
  String amount;
  String issuer;
  String owners;
  String sender;
  String symbol;
  String wallet;
  String weights;
  String coin_base;
  String confirmed;
  String due_block;
  String recipient;
  String threshold;
  String coin_check;
  String commission;
  String amount_base;
  String coin_to_buy;
  String nonce_check;
  String transaction;
  String amount_check;
  String coin_to_sell;
  String limit_volume;
  String amount_to_buy;
  String confirmations;
  String signer_weight;
  String amount_to_sell;
  String initial_volume;
  String reward_address;
  String completion_time;
  String initial_reserve;
  String delegator_address;
  String min_amount_to_buy;
  String validator_address;
  String max_amount_to_sell;
  String multisend_receivers;
  String constant_reserve_ratio;

  TxData({
    this.log,
    this.coin,
    this.check,
    this.coins,
    this.proof,
    this.title,
    this.amount,
    this.issuer,
    this.owners,
    this.sender,
    this.symbol,
    this.wallet,
    this.weights,
    this.coin_base,
    this.confirmed,
    this.due_block,
    this.recipient,
    this.threshold,
    this.coin_check,
    this.commission,
    this.amount_base,
    this.coin_to_buy,
    this.nonce_check,
    this.transaction,
    this.amount_check,
    this.coin_to_sell,
    this.limit_volume,
    this.amount_to_buy,
    this.confirmations,
    this.signer_weight,
    this.amount_to_sell,
    this.initial_volume,
    this.reward_address,
    this.completion_time,
    this.initial_reserve,
    this.delegator_address,
    this.min_amount_to_buy,
    this.validator_address,
    this.max_amount_to_sell,
    this.multisend_receivers,
    this.constant_reserve_ratio,
  });
  factory TxData.fromJson(Map<String, dynamic> json){
    return TxData(
      log: json['log'] == null?"":json['log'],
      coin: json['coin'] == null?"":json['coin'],
      check: json['check'] == null?"":json['check'],
      coins: json['coins'] == null?"":json['coins'],
      proof: json['proof'] == null?"":json['proof'],
      title: json['title'] == null?"":json['title'],
      amount: json['amount'] == null?"":json['amount'],
      issuer: json['issuer'] == null?"":json['issuer'],
      owners: json['owners'] == null?"":json['owners'],
      sender: json['sender'] == null?"":json['sender'],
      symbol: json['symbol'] == null?"":json['symbol'],
      wallet: json['wallet'] == null?"":json['wallet'],
      weights: json['weights'] == null?"":json['weights'],
      coin_base: json['coin_base'] == null?"":json['coin_base'],
      confirmed: json['confirmed'] == null?"":json['confirmed'],
      due_block: json['due_block'] == null?"":json['due_block'],
      recipient: json['recipient'] == null?"":json['recipient'],
      threshold: json['threshold'] == null?"":json['threshold'],
      coin_check: json['coin_check'] == null?"":json['coin_check'],
      commission: json['commission'] == null?"":json['commission'],
      amount_base: json['amount_base'] == null?"":json['amount_base'],
      coin_to_buy: json['coin_to_buy'] == null?"":json['coin_to_buy'],
      nonce_check: json['nonce_check'] == null?"":json['nonce_check'],
      transaction: json['transaction'] == null?"":json['transaction'],
      amount_check: json['amount_check'] == null?"":json['amount_check'],
      coin_to_sell: json['coin_to_sell'] == null?"":json['coin_to_sell'],
      limit_volume: json['limit_volume'] == null?"":json['limit_volume'],
      amount_to_buy: json['amount_to_buy'] == null?"":json['amount_to_buy'],
      confirmations: json['confirmations'] == null?"":json['confirmations'],
      signer_weight: json['signer_weight'] == null?"":json['signer_weight'],
      amount_to_sell: json['amount_to_sell'] == null?"":json['amount_to_sell'],
      initial_volume: json['initial_volume'] == null?"":json['initial_volume'],
      reward_address: json['reward_address'] == null?"":json['reward_address'],
      completion_time: json['completion_time'] == null?"":json['completion_time'],
      initial_reserve: json['initial_reserve'] == null?"":json['initial_reserve'],
      delegator_address: json['delegator_address'] == null?"":json['delegator_address'],
      min_amount_to_buy: json['min_amount_to_buy'] == null?"":json['min_amount_to_buy'],
      validator_address: json['validator_address'] == null?"":json['validator_address'],
      max_amount_to_sell: json['max_amount_to_sell'] == null?"":json['gas_used'],
      multisend_receivers: json['multisend_receivers'] == null?"":json['multisend_receivers'],
      constant_reserve_ratio: json['constant_reserve_ratio'] == null?"":json['constant_reserve_ratio'],
    );
  }
}