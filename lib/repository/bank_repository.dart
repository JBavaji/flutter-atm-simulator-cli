import '../models/transaction.dart';
import '../util/results.dart';

abstract class BankRepository {
  CommandResults login(String username);

  CommandResults logout();

  CommandResults saveActivity();

  CommandResults transaction(double amount, TransactionType type);
}
