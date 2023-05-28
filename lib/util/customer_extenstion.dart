import 'package:flutter_atm_simulator_cli/models/customer_transaction.dart';

import '../models/customer.dart';

extension CustomerMessages on Customer {
  String get welcome => "Hello, $username!\n$transactionBalance";

  String get transactionBalance => "Your balance is ${balance.toString()}";

  String get goodBye => "Goodbye, $username!";

  String get continueTransaction =>
      'You can continue transaction with existing $username';

  get notEnoughBalance => "You don't have enough balance.\n$transactionBalance";

  int incrementedId() {
    int count = transaction.length;
    if (count == 0) {
      return 1;
    } else {
      int id = transaction[count - 1].id as int;
      return ++id;
    }
  }

  String statement() {
    var prompt = StringBuffer();

    if (transaction.isEmpty) {
      prompt.writeln('No transactions found');
    } else {
      for (CustomerTransaction element in transaction) {
        prompt.writeln(element.toString());
      }
    }

    return prompt.toString();
  }
}

extension NoCustomer on String {
  String get noCustomerLogged => "No logged customer found";
}
