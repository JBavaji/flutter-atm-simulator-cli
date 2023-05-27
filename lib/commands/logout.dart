import 'dart:io';

import 'package:args/args.dart';

import 'command.dart';

class LogoutCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandLogout = 'logout';

  @override
  String get name => commandLogout;

  @override
  String get description => "Logout user.";

  @override
  execute(ArgResults results) {
    var logout = StringBuffer();
    logout
      ..writeln('Goodbye!!!')
      ..writeln('Logout successfully');

    stdout.writeln(logout.toString());
  }
}
