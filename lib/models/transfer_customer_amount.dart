/*
    Sample transfer amount customer

   {
    "username": "jbavaji",
    "balance": 40
  }
 */

import 'dart:convert';

import 'account_balance.dart';

CustomerOweAmount customerTransferAmountFromJson(String str) =>
    CustomerOweAmount.fromJson(json.decode(str));

String customerTransferAmountToJson(CustomerOweAmount data) =>
    json.encode(data.toJson());

class CustomerOweAmount {
  CustomerOweAmount({
    AccountBalance? amount,
    String? username,
  }) {
    _amount = amount;
    _username = username;
  }

  CustomerOweAmount.fromJson(dynamic json) {
    _amount = AccountBalance(json['amount'] as double);
    _username = json['username'];
  }

  AccountBalance? _amount;
  String? _username;

  CustomerOweAmount copyWith({
    AccountBalance? amount,
    String? username,
  }) =>
      CustomerOweAmount(
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
