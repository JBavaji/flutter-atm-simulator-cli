import 'dart:io';

import 'package:args/args.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/customer_extenstion.dart';
import '../util/results.dart';
import 'command.dart';

class DepositCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandDeposit = 'deposit';
  static const String optionAmount = 'amount';

  @override
  String get name => commandDeposit;

  @override
  String get description =>
      "Deposit amount in user account and add transaction record.";

  BankRepositoryImpl repositoryImpl = BankRepositoryImpl();
  BankData data = BankData.instance;

  @override
  execute(ArgResults results) {
    String amount = results[optionAmount] ?? '';

    if (!data.loggedIn) {
      stdout.writeln("".noCustomerLogged);
      return;
    }

    if (amount.isEmpty) {
      stdout.writeln('Deposit amount missing:');
      amount = stdin.readLineSync() ?? "";
    }

    try {
      double amountValue = double.parse(amount);
      CommandResults result = repositoryImpl.deposit(amountValue);

      if (result == CommandResults.deposit) {
        stdout.writeln('${data.customer?.deposit}');
      }
    } on Exception catch (err) {
      stdout.writeln('Invalid amount entered, Number exception occurred');
    }
  }
}
