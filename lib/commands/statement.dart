import 'dart:io';

import 'package:args/args.dart';

import '../util/customer_extenstion.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import 'command.dart';

class StatementCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandStatement = 'statement';

  @override
  String get name => commandStatement;

  @override
  String get description =>
      'Statement - Transaction statement for current customer.';

  BankRepositoryImpl repositoryImpl = BankRepositoryImpl();
  BankData data = BankData.instance;

  @override
  execute(ArgResults results) {
    if (!data.loggedIn) {
      stdout.writeln("".noCustomerLogged);
      return;
    }

    stdout.writeln(data.customer?.welcome);
    stdout.writeln(data.customer?.statement());
  }
}
