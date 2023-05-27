import 'dart:io';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flutter_atm_simulator_cli/commands/commands.dart';

class AtmSimulatorCommandRunner extends CommandRunner<int> {
  AtmSimulatorCommandRunner()
      : super(
          'atm_simulator_cli',
          'A ATM Simulator Command-Line Interface',
        );

  @override
  Future<int> run(Iterable<String> args) async {
    ArgParser parser = ArgParser();
    parser
      ..addCommand(HelpCommand.commandHelp)
      ..addCommand(LoginCommand.commandLogin)
      ..addOption(LoginCommand.optionUserName, abbr: LoginCommand.abbrUserName);

    final argResults = parser.parse(args);

    switch (argResults.command?.name) {
      case HelpCommand.commandHelp:
        HelpCommand().execute(argResults);
        return exit(0);

      case LoginCommand.commandLogin:
        LoginCommand().execute(argResults);
        return exit(0);

      default:
        UnknownCommand().execute(argResults);
        return exit(0);
    }
  }
}
