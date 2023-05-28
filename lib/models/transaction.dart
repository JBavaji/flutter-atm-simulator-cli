import 'dart:convert';

/*
    Sample transaction

    {
        "id": 1
        "type": "deposit",
        "amount": 100,
        "username": "jbavaji"
      }
 */

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

enum TransactionType {
  deposit,
  withdraw;

  String toJson() => name;

  static TransactionType fromJson(String json) => values.byName(json);
}

class Transaction {
  Transaction({
    int? id,
    TransactionType? type,
    num? amount,
    String? username,
  }) {
    _id = id;
    _type = type;
    _amount = amount;
    _username = username;
  }

  Transaction.fromJson(dynamic json) {
    _id = json['id'];
    _type = TransactionType.fromJson(json['type']);
    _amount = json['amount'];
    _username = json['username'];
  }

  int? _id;
  TransactionType? _type;
  num? _amount;
  String? _username;

  Transaction copyWith({
    int? id,
    TransactionType? type,
    num? amount,
    String? username,
  }) =>
      Transaction(
        id: id ?? _id,
        type: type ?? _type,
        amount: amount ?? _amount,
        username: username ?? _username,
      );

  int? get id => _id;

  set setId(int? value) {
    _id = value;
  }

  TransactionType? get type => _type;

  num? get amount => _amount;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type?.name,
      "amount": amount,
      "username": username,
    };
  }
}
