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

CustomerTransaction transactionFromJson(String str) =>
    CustomerTransaction.fromJson(json.decode(str));

String transactionToJson(CustomerTransaction data) =>
    json.encode(data.toJson());

enum TransactionType {
  deposit,
  withdraw,
  sent,
  received;

  String toJson() => name;

  static TransactionType fromJson(String json) => values.byName(json);
}

class CustomerTransaction {
  CustomerTransaction({
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

  CustomerTransaction.fromJson(dynamic json) {
    _id = json['id'];
    _type = TransactionType.fromJson(json['type']);
    _amount = json['amount'];
    _username = json['username'];
  }

  int? _id;
  TransactionType? _type;
  num? _amount;
  String? _username;

  CustomerTransaction copyWith({
    int? id,
    TransactionType? type,
    num? amount,
    String? username,
  }) =>
      CustomerTransaction(
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

  @override
  String toString() {
    return "You ${type?.name} amount \$$amount.";
  }
}
