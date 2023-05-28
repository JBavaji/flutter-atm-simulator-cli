/*
    Sample transfer amount customer

   {
    "username": "jbavaji",
    "balance": 40
  }
 */

import 'dart:convert';

import 'account_balance.dart';

CustomerTransferAmount customerTransferAmountFromJson(String str) =>
    CustomerTransferAmount.fromJson(json.decode(str));

String customerTransferAmountToJson(CustomerTransferAmount data) =>
    json.encode(data.toJson());

class CustomerTransferAmount {
  CustomerTransferAmount({
    AccountBalance? amount,
    String? username,
  }) {
    _amount = amount;
    _username = username;
  }

  CustomerTransferAmount.fromJson(dynamic json) {
    _amount = AccountBalance(json['amount'] as double);
    _username = json['username'];
  }

  AccountBalance? _amount;
  String? _username;

  CustomerTransferAmount copyWith({
    AccountBalance? amount,
    String? username,
  }) =>
      CustomerTransferAmount(
        amount: amount ?? _amount,
        username: username ?? _username,
      );

  AccountBalance? get amount => _amount;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    return {
      "amount": amount?.balance,
      "username": username,
    };
  }
}
