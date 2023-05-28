import 'dart:io';

import 'package:args/args.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/customer_extenstion.dart';
import '../util/error_message_extenstion.dart';
import '../util/results.dart';
import 'command.dart';

class TransferCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandTransfer = 'transfer';
  static const String optionToUsername = 'username';
  static const String optionAmount = 'amount';

  ///   transfer --amount $$ --username @@@@@
  ///   transfer --amount 20 --username jbavaji

  @override
  String get name => commandTransfer;

  @override
  String get description =>
      "Transfer amount in to user account and add transaction record.";

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

    double amountValue = 0;

    try {
      amountValue = double.parse(amount);
    } on Exception catch (err) {
      stdout.writeln('Invalid amount entered, Number exception occurred');
    }

    String username = results[optionToUsername] ?? '';
    if (username.isEmpty) {
      stdout.writeln('Username:');
      username = stdin.readLineSync() ?? "";
    }

    if (username == data.customer?.username) {
      stdout.writeln(data.customer?.selfTransferNotValid);
      return;
    }

    if (username.isEmpty) {
      stdout.writeln(" ".emptyCustomerUsername);
      return;
    }

    CommandResults result = repositoryImpl.transfer(amountValue, username);

    if (result == CommandResults.customerNotExists) {
      stdout.writeln('${" ".noCustomerFound} - \"$username\"');
    } else if (result == CommandResults.notEnoughBalance) {
      stdout.writeln('${data.customer?.notEnoughBalance}');
    } else {
      stdout.writeln('You transferred \$$amount to $username.');
      stdout.writeln(data.customer?.transactionBalance);
    }
  }
}
