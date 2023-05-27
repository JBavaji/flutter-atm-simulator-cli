extension BalanceAmount on double {
  double deposit(double amount) => this + amount;

  double withdraw(double amount) => this + amount;

  bool zero() => this <= 0;

  bool canWithdraw(double amount) => (this - amount) < 0;
}
