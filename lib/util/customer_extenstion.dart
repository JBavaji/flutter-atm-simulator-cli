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
}
