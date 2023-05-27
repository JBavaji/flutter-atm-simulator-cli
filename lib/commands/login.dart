import 'dart:io';

import 'package:args/args.dart';

import 'command.dart';

class LoginCommand extends Command {
  /// The [name] of the command. But static.
  static const String commandLogin = 'login';
  static const String optionUserName = 'username';
  static const String abbrUserName = 'u';

  @override
  String get name => commandLogin;

  @override
  String get description => "Login user banking.";

  @override
  execute(ArgResults results) {
    String username = results[optionUserName] ?? '';

    ///  username not passed in argument
    ///  ask for username to be continue
    if (username.isEmpty) {
      stdout.writeln('Username required: ');
      username = stdin.readLineSync() ?? "";
    }

    var welcome = StringBuffer();
    welcome
      ..writeln('Hello, $username!')
      ..writeln('Your balance is INR 0.0');

    stdout.writeln(welcome.toString());
  }
}
