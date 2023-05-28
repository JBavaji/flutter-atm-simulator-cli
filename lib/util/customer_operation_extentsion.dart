import '../commands/statement.dart';
import '../models/customer.dart';
import '../models/customer_transaction.dart';

extension CustomerOperation on Customer {
  int incrementedId() {
    int count = transaction.length;
    if (count == 0) {
      return 1;
    } else {
      int id = transaction[count - 1].id as int;
      return ++id;
    }
  }

  String statement(String? type) {
    var prompt = StringBuffer();

    if (transaction.isEmpty) {
      prompt.writeln('No transactions found');
    } else {
      List<CustomerTransaction> transactions = transaction.reversed.toList();

      if (type == StatementCommand.typeMini) {
        transactions = transactions.sublist(0, 3);
      }

      prompt.writeln();
      prompt.writeln('Your transactions:');
      for (CustomerTransaction element in transactions) {
        prompt.writeln(element.toString());
      }
    }

    return prompt.toString();
  }

  bool haveEnoughBalance(amount) {
    return balance!.enoughBalance(amount);
  }

  int findUserFromReceived(String? username) {
    return received.indexWhere(
      (element) => element.username == username,
    );
  }

  String owedFromAmountStatement() {
    var prompt = StringBuffer();

    for (var element in sent) {
      prompt.writeln(
          'Owed ${element.amount.toString()} from ${element.username}');
    }

    return prompt.toString();
  }

  String owedToAmountStatement() {
    var prompt = StringBuffer();

    for (var element in received) {
      prompt
          .writeln('Owed ${element.amount.toString()} to ${element.username}');
    }

    return prompt.toString();
  }
}
