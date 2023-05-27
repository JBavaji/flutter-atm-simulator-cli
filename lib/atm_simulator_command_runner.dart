import 'dart:io';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'command_executor.dart';
import 'commands/commands.dart';

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
      ..addOption(LoginCommand.optionUserName)
      ..addCommand(LogoutCommand.commandLogout);

    final argResults = parser.parse(args);

    CommandExecutor().commandArgumentExecuteResult(argResults);
    return exit(0);
  }
}
