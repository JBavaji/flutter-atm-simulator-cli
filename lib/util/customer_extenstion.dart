import '../commands/statement.dart';
import '../models/customer_transaction.dart';
import '../models/customer.dart';

extension CustomerMessages on Customer {
  String get welcome => "Hello, $username!\n$transactionBalance";

  String get transactionBalance => "Your balance is ${balance.toString()}";

  String get goodBye => "Goodbye, $username!";

  String get continueTransaction =>
      'You can continue transaction with existing $username';

  String get selfTransferNotValid => 'You can not transfer to your own account';

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
}

extension NoCustomer on String {
  String get noCustomerLogged => "No logged customer.";

  String get noCustomerFound => "No customer found with username";

  String get emptyCustomerUsername => "Username can not be empty for transfer.";
}
