import 'dart:io';

class UnknownCommand {
  execute() {
    stdout.writeln(
        'Unknown command. User "help" to know more about supported commands');
  }
}
