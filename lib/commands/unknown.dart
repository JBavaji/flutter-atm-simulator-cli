import 'dart:io';
import 'command.dart';

class UnknownCommand extends Command {
  @override
  execute() {
    var unknown = StringBuffer();
    unknown
      ..writeln('Unknown command.')
      ..writeln('User "help" to know more about supported commands');

    stdout.writeln(unknown.toString());
  }
}
