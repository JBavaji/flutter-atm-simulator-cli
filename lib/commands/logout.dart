import 'dart:io';
import 'package:args/args.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/results.dart';
import '../util/customer_extenstion.dart';
import '../util/error_message_extenstion.dart';
import 'command.dart';

class LogoutCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandLogout = 'logout';

  @override
  String get name => commandLogout;

  @override
  String get description => "Logout user.";

  BankRepositoryImpl repositoryImpl = BankRepositoryImpl();
  BankData data = BankData.instance;

  @override
  execute(ArgResults results) {
    CommandResults? result = repositoryImpl.logout();

    if (result == CommandResults.alreadyLogout) {
      stdout.writeln("".noCustomerLogged);
    } else {
      stdout.writeln(data.customer?.goodBye);
    }
  }
}
