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
      ..addCommand(DepositCommand.commandDeposit)
      ..addCommand(WithdrawCommand.commandWithdraw)
      ..addOption(DepositCommand.optionAmount)
      ..addCommand(StatementCommand.commandStatement)
      ..addOption(StatementCommand.optionType)
      ..addCommand(TransferCommand.commandTransfer)
      ..addCommand(LogoutCommand.commandLogout);

    try {
      final argResults = parser.parse(args);
      CommandExecutor().commandArgumentExecuteResult(argResults);
    } on Exception catch (e) {
      stdout.writeln(e.toString());
      stdout.writeln("Run 'help' command to get more help.");
    }

    return exit(0);
  }
}
