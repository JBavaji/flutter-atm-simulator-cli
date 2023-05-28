import 'dart:io';
import 'package:args/args.dart';

import '../models/transaction.dart';
import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/customer_extenstion.dart';
import '../util/results.dart';
import 'command.dart';

class TransactionCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandDeposit = 'deposit';
  static const String commandWithdraw = 'withdraw';
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
    TransactionType transactionType = results.command?.name == commandDeposit
        ? TransactionType.deposit
        : TransactionType.withdraw;

    if (amount.isEmpty) {
      stdout.writeln('Amount:');
      amount = stdin.readLineSync() ?? "";
    }

    try {
      double amountValue = double.parse(amount);
      CommandResults result =
          repositoryImpl.transaction(amountValue, transactionType);

      if (result == CommandResults.transaction) {
        stdout.writeln('${data.customer?.transactionBalance}');
      } else {
        stdout.writeln('${data.customer?.notEnoughBalance}');
      }
    } on Exception catch (err) {
      stdout.writeln('Invalid amount entered, Number exception occurred');
    }
  }
}
