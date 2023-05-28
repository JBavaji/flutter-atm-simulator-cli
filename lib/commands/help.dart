import 'dart:io';
import 'package:args/args.dart';

import 'command.dart';

class HelpCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandHelp = 'help';

  @override
  String get name => commandHelp;

  @override
  String get description =>
      'Help - Lists commands which can use during the Atm Simulator process.';

  @override
  execute(ArgResults results) {
    var content = StringBuffer();
    content
      ..writeln('')
      ..writeln('+---------------------------------------------------  +')
      ..writeln('|           Welcome to the ATM Simulate!              |')
      ..writeln('+---------------------------------------------------  +')
      ..writeln()
      ..writeln()
      ..writeln(
          'login [--username @@@] - Logs in as this customer. and creates the customer if not exist')
      ..writeln(
          'deposit [--amount \$\$\$] - Deposits this amount to the logged in customer')
      ..writeln(
          'withdraw [--amount \$\$\$] - Withdraws this amount from the logged in customer')
      ..writeln(
          'statement [--type mini/all]- Print of the current customer transaction.')
      ..writeln(
          'statement [--type mini] - Most recent 1o transactions of current customer.')
      ..writeln(
          'statement [--type all] - All transactions of current customer.')
      ..writeln('logout - Logs out of the current customer')
      ..writeln('help - Get help for supported command to use ATM simulator')
      ..writeln()
      ..writeln('+---------------------------------------------------  +')
      ..writeln('|           Developer: Jayeshgiri Bavaji              |')
      ..writeln('| Email: jbavaji@gmail.com | Contact: +91 96018 33544 | ')
      ..writeln('+---------------------------------------------------  +')
      ..writeln();

    stdout.writeln(content.toString());
  }
}
