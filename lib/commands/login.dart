import 'dart:io';
import 'package:args/args.dart';

import '../repository/bank_data.dart';
import '../repository/bank_repository_impl.dart';
import '../util/results.dart';
import '../util/customer_extenstion.dart';
import '../util/error_message_extenstion.dart';
import 'command.dart';

class LoginCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandLogin = 'login';
  static const String optionUserName = 'username';

  @override
  String get name => commandLogin;

  @override
  String get description => "Login user banking.";

  BankRepositoryImpl repositoryImpl = BankRepositoryImpl();
  BankData data = BankData.instance;

  @override
  execute(ArgResults results) {
    String username = results[optionUserName] ?? '';

    ///  username not passed in argument
    ///  ask for username to be continue
    if (username.isEmpty) {
      stdout.writeln('Username required:');
      username = stdin.readLineSync() ?? "";
    }

    CommandResults? result = repositoryImpl.login(username);

    if (result == CommandResults.alreadyLoggedIn) {
      var prompt = StringBuffer();
      prompt
        ..writeln('${data.customer?.username} already loggedIn.')
        ..writeln(
            'Need to logout before continue. Press Enter or Key press Y/y...');

      stdout.writeln(prompt.toString());

      String action = stdin.readLineSync() ?? "";
      if (action == "N" || action == 'n') {
        stdout.writeln('${data.customer?.continueTransaction}');
      } else {
        result = repositoryImpl.logout();

        if (result == CommandResults.alreadyLogout) {
          stdout.writeln("".noCustomerLogged);
        } else {
          stdout.writeln(data.customer?.goodBye);
        }
      }
    } else {
      stdout.writeln(data.customer?.welcome);
    }
  }
}
