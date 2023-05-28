import 'dart:io';

import 'package:args/args.dart';

import '../util/customer_extenstion.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import 'command.dart';

class StatementCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandStatement = 'statement';

  /// Statement type can be
  /// mini - Most recent 1o transactions
  /// all - all transactions
  /// default mini - Most recent transactions
  static const String optionType = 'type';
  static const String typeMini = 'mini';
  static const String typeAll = 'all';

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

    String type = results[optionType] ?? '';

    stdout.writeln(data.customer?.welcome);
    stdout.writeln(data.customer?.statement(type));
  }
}
