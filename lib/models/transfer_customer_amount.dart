/*
    Sample transfer amount customer

   {
    "username": "jbavaji",
    "balance": 40
  }
 */

import 'dart:convert';

CustomerTransferAmount customerTransferAmountFromJson(String str) =>
    CustomerTransferAmount.fromJson(json.decode(str));

String customerTransferAmountToJson(CustomerTransferAmount data) =>
    json.encode(data.toJson());

class CustomerTransferAmount {
  CustomerTransferAmount({
    num? amount,
    String? username,
  }) {
    _amount = amount;
    _username = username;
  }

  CustomerTransferAmount.fromJson(dynamic json) {
    _amount = json['amount'];
    _username = json['username'];
  }

  num? _amount;
  String? _username;

  CustomerTransferAmount copyWith({
    num? amount,
    String? username,
  }) =>
      CustomerTransferAmount(
        amount: amount ?? _amount,
        username: username ?? _username,
      );

  num? get amount => _amount;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "username": username,
    };
  }
}
