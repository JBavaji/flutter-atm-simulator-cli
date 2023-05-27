import 'dart:convert';

import 'account_balance.dart';
import 'transaction.dart';

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
    List<Transaction>? transaction,
    bool? loggedIn,
  }) {
    _username = username;
    _balance = balance;
    _transaction = transaction;
    _loggedIn = loggedIn;
  }

  Customer.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _balance = AccountBalance((json['balance']));
    if (json['transaction'] != null) {
      _transaction = [];
      json['transaction'].forEach((v) {
        _transaction?.add(Transaction.fromJson(v));
      });
    }
    _loggedIn = json['loggedIn'];
  }

  String? _username;
  AccountBalance? _balance;
  List<Transaction>? _transaction;
  bool? _loggedIn;

  Customer copyWith({
    String? username,
    AccountBalance? balance,
    List<Transaction>? transaction,
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

  List<Transaction>? get transaction => _transaction;

  bool? get loggedIn => _loggedIn;

  set setLoggedIn(bool? value) => _loggedIn = value;

  Map<String, dynamic> toJson() {
    return {
    "username": username,
    "balance": balance?.balance,
    "loggedIn" : loggedIn,
    "transaction": transaction?.map((v) => v.toJson()).toList()
  };}
}
