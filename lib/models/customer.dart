import 'dart:convert';

import 'account_balance.dart';
import 'customer_transaction.dart';

/*
    Sample customer

   {
    "username": "jbavaji",
    "balance": 40,
    "transaction": [
      {
        "type": "deposit",
        "amount": 100,
        "username": "jbavaji"
      }
    ]
  }
 */

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    String? username,
    AccountBalance? balance,
    List<CustomerTransaction>? transaction,
    bool? loggedIn,
  }) {
    _username = username;
    _balance = balance;
    _transaction = transaction;
    _loggedIn = loggedIn;
  }

  Customer.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _balance = AccountBalance(json['balance'] as double);
    if (json['transaction'] != null) {
      _transaction = [];
      json['transaction'].forEach((v) {
        _transaction?.add(CustomerTransaction.fromJson(v));
      });
    }
    _loggedIn = json['loggedIn'];
  }

  String? _username;
  AccountBalance? _balance;
  List<CustomerTransaction>? _transaction;
  bool? _loggedIn;

  Customer copyWith({
    String? username,
    AccountBalance? balance,
    List<CustomerTransaction>? transaction,
    bool? loggedIn,
  }) =>
      Customer(
        username: username ?? _username,
        balance: balance ?? _balance,
        transaction: transaction ?? _transaction,
        loggedIn: loggedIn ?? _loggedIn,
      );

  String? get username => _username;

  AccountBalance? get balance => _balance;

  List<CustomerTransaction> get transaction => _transaction ?? [];

  bool? get loggedIn => _loggedIn;

  set setLoggedIn(bool? value) => _loggedIn = value;

  set setTransaction(List<CustomerTransaction>? value) {
    _transaction = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "balance": balance?.balance,
      "loggedIn": loggedIn,
      "transaction": transaction.map((v) => v.toJson()).toList()
    };
  }
}
