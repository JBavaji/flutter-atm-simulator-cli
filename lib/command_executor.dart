import 'dart:io';
import 'package:args/args.dart';

import 'commands/commands.dart';

class CommandExecutor {
  commandArgumentExecuteResult(ArgResults argResults) {
    try {
      switch (argResults.command?.name) {
        case HelpCommand.commandHelp:
          HelpCommand().execute(argResults);
          return;

        case LoginCommand.commandLogin:
          LoginCommand().execute(argResults);
          return;

        case LogoutCommand.commandLogout:
          LogoutCommand().execute(argResults);
          return;

        default:
          UnknownCommand().execute(argResults);
          return;
      }
    } on Exception catch (err) {
      stdout.writeln('Exception occurred, $err');
    }
  }
}