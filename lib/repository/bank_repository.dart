import '../util/results.dart';

abstract class BankRepository {
  CommandResults login(String username);

  CommandResults logout();

  CommandResults saveActivity();

  CommandResults deposit(double amount);
}
