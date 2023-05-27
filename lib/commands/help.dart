import 'dart:io';
import 'package:args/command_runner.dart';

class HelpCommand extends Command<int> {
  @override
  String get description =>
      'Help - Lists commands which can use during the Atm Simulator process.';

  /// The [name] of the command. But static.
  static const String commandHelp = 'help';

  @override
  String get name => commandHelp;

  execute() {
    const welcome = '''
+---------------------------------------------------  +
|           Welcome to the ATM Simulate!              |
+---------------------------------------------------  +
\n
''';

    const help = '''
help - To know supported command to use ATM simulator \n
''';

    const developer = '''
+---------------------------------------------------  +
|           Developer: Jayeshgiri Bavaji              |
| Email: jbavaji@gmail.com | Contact: +91 96018 33544 |                    
+---------------------------------------------------  +   
\n
''';

    stdout.writeln(welcome + help + developer);
  }
}
