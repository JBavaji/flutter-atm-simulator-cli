import 'dart:convert';

/*
    Sample transaction

    {
        "type": "deposit",
        "amount": 100,
        "username": "jbavaji"
      }
 */

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    String? type,
    num? amount,
    String? username,
  }) {
    _type = type;
    _amount = amount;
    _username = username;
  }

  Transaction.fromJson(dynamic json) {
    _type = json['type'];
    _amount = json['amount'];
    _username = json['username'];
  }

  String? _type;
  num? _amount;
  String? _username;

  Transaction copyWith({
    String? type,
    num? amount,
    String? username,
  }) =>
      Transaction(
        type: type ?? _type,
        amount: amount ?? _amount,
        username: username ?? _username,
      );

  String? get type => _type;

  num? get amount => _amount;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['amount'] = _amount;
    map['username'] = _username;
    return map;
  }
}
