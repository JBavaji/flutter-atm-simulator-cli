import 'dart:io';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class AtmSimulatorCommandRunner extends CommandRunner<int> {
  AtmSimulatorCommandRunner()
      : super('atm_simulator_cli', 'A ATM Simulator Command-Line Interface') {}

  @override
  Future<int> run(Iterable<String> args) async {
    ArgParser parser = ArgParser();
        parser.addCommand('help');

    final argResults = parser.parse(args);

    switch (argResults.command?.name) {
      case 'help':
        print('Help Command detect');
        return exit(0);

      default:
        print('Unknown command. User "help" for supported commands');
        return exit(0);
    }
  }
}
