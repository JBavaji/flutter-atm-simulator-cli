import 'package:flutter_atm_simulator_cli/util/balance_extension.dart';

/*
    Help to do routine banking activities related to balance
 */

class AccountBalance {
  double balance = 0;

  AccountBalance(this.balance);

  bool zeroBalance() {
    return balance.zero();
  }

  void deposit(double amount) {
    balance = balance.deposit(amount);
  }

  num getBalance() {
    return balance;
  }

  void withdraw(double amount) {
    if ((balance - amount) < 0) {
      throw Exception("Not enough balance");
    }
    balance = balance.withdraw(amount);
  }

  @override
  String toString() {
    return "INR $balance";
  }
}
