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
      ..writeln('+----------------------------------------------------------+')
      ..writeln('|           Welcome to the ATM Simulate!                   |')
      ..writeln('+----------------------------------------------------------+')
      ..writeln()
      ..writeln('login [--username @@@]')
      ..writeln('Logs in or this create as this customer')
      ..writeln()
      ..writeln('deposit [--amount \$\$\$]')
      ..writeln('Deposit this amount to the logged in customer')
      ..writeln()
      ..writeln('withdraw [--amount \$\$\$]')
      ..writeln('Withdraw this amount from the logged in customer')
      ..writeln()
      ..writeln('statement [--type mini/all]')
      ..writeln('List out the current customer transaction.')
      ..writeln('[mini] - Most recent 1o transactions of current customer.')
      ..writeln('[all] - All transactions of current customer.')
      ..writeln()
      ..writeln('transfer [--amount \$\$\$ --username @@@] ')
      ..writeln(
          'Transfer this amount to user from the logged in customer to target customer.')
      ..writeln()
      ..writeln('logout')
      ..writeln('Logs out of the current customer')
      ..writeln()
      ..writeln('help')
      ..writeln('To understanding supported command and how to use simulates ATM Banking.')
      ..writeln()
      ..writeln('+----------------------------------------------------------+')
      ..writeln('|    Developer: Jayeshgiri Bavaji (JBavaji)                |')
      ..writeln('|    Website: https://jbavaji.github.io                    |')
      ..writeln('|    Email: jbavaji@gmail.com                              |')
      ..writeln('|    Contact: +91 96018 33544                              |')
      ..writeln('+----------------------------------------------------------+')
      ..writeln();

    stdout.writeln(content.toString());
  }
}
