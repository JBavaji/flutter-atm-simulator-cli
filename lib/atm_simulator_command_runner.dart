import 'dart:io';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'command_executor.dart';
import 'commands/commands.dart';
import 'repository/bank_data.dart';

class AtmSimulatorCommandRunner extends CommandRunner<int> {
  AtmSimulatorCommandRunner()
      : super(
          'atm_simulator_cli',
          'A ATM Simulator Command-Line Interface',
        ) {
    BankData.instance.appInitialize();
  }

  @override
  Future<int> run(Iterable<String> args) async {
    ArgParser parser = ArgParser();
    parser
      ..addCommand(HelpCommand.commandHelp)
      ..addCommand(LoginCommand.commandLogin)
      ..addOption(LoginCommand.optionUserName)
      ..addCommand(TransactionCommand.commandDeposit)
      ..addCommand(TransactionCommand.commandWithdraw)
      ..addOption(TransactionCommand.optionAmount)
      ..addCommand(StatementCommand.commandStatement)
      ..addOption(StatementCommand.optionType)
      ..addCommand(LogoutCommand.commandLogout);

    try {
      final argResults = parser.parse(args);
      CommandExecutor().commandArgumentExecuteResult(argResults);
    } on Exception catch (e) {
      print(e.toString());
      print("Run 'help' command to get more help.");
    }

    return exit(0);
  }
}
