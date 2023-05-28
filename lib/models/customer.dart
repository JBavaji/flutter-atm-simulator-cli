import 'dart:convert';

import 'account_balance.dart';
import 'customer_transaction.dart';
import 'transfer_customer_amount.dart';

/*
    Sample customer

   {
    "username": "jbavaji",
    "balance": 40,
    "sent": [
      {
        "username": "jack",
        "amount": 20.0
      }
    ],
    "received": [
      {
        "username": "jayeshgiri",
        "amount": 20.0
      }
    ],
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
    List<CustomerOweAmount>? sent,
    List<CustomerOweAmount>? received,
    bool? loggedIn,
  }) {
    _username = username;
    _balance = balance;
    _transaction = transaction;
    _sent = sent;
    _received = received;
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
    if (json['sent'] != null) {
      _sent = [];
      json['sent'].forEach((v) {
        _sent?.add(CustomerOweAmount.fromJson(v));
      });
    }
    if (json['received'] != null) {
      _received = [];
      json['received'].forEach((v) {
        _received?.add(CustomerOweAmount.fromJson(v));
      });
    }
    _loggedIn = json['loggedIn'];
  }

  String? _username;
  AccountBalance? _balance;
  List<CustomerTransaction>? _transaction;
  List<CustomerOweAmount>? _sent;
  List<CustomerOweAmount>? _received;

  bool? _loggedIn;

  String? get username => _username;

  AccountBalance? get balance => _balance;

  List<CustomerTransaction> get transaction => _transaction ?? [];

  List<CustomerOweAmount> get received => _received ?? [];

  List<CustomerOweAmount> get sent => _sent ?? [];

  bool? get loggedIn => _loggedIn;

  set setLoggedIn(bool? value) => _loggedIn = value;

  set setTransaction(List<CustomerTransaction>? value) {
    _transaction = value;
  }

  set setSent(List<CustomerOweAmount>? value) {
    _sent = value;
  }

  set setReceived(List<CustomerOweAmount>? value) {
    _received = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "balance": balance?.balance,
      "loggedIn": loggedIn,
      "transaction": transaction.map((v) => v.toJson()).toList(),
      "sent": sent.map((v) => v.toJson()).toList(),
      "received": received.map((v) => v.toJson()).toList(),
    };
  }
}
