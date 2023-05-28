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

  bool enoughBalance(amount) {
    return balance.canWithdraw(amount);
  }

  void withdraw(double amount) {
    if (enoughBalance(amount)) {
      balance = balance.withdraw(amount);
    } else {
      throw Exception("Not enough balance");
    }
  }

  @override
  String toString() {
    return "\$$balance";
  }
}
