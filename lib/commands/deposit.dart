import 'dart:io';
import 'package:args/args.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/customer_extenstion.dart';
import '../util/error_message_extenstion.dart';
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
    if (!data.loggedIn) {
      stdout.writeln("".noCustomerLogged);
      return;
    }

    String amount = results[optionAmount] ?? '';

    if (amount.isEmpty) {
      stdout.writeln('Amount:');
      amount = stdin.readLineSync() ?? "";
    }
    double amountValue = -1;
    try {
      amountValue = double.parse(amount);

      if (amountValue < 0) {
        stdout.writeln("".negativeNumber);
        return;
      }
    } on Exception {
      stdout.writeln("".invalidNumber);
      return;
    }

    CommandResults result = repositoryImpl.deposit(amountValue);

    if (result == CommandResults.deposit) {
      stdout.writeln('${data.customer?.transactionBalance}');
    }
  }
}
