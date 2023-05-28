import '../models/customer_transaction.dart';
import '../util/results.dart';

abstract class BankRepository {
  CommandResults login(String username);

  CommandResults logout();

  CommandResults saveActivity();

  CommandResults deposit(double amount);

  CommandResults withdraw(double amount);

  CommandResults transfer(double amount, String username);
}
