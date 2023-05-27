import 'dart:io';
import 'package:args/args.dart';

import 'command.dart';

class UnknownCommand extends Command {
  @override
  execute(ArgResults results) {
    var unknown = StringBuffer();
    unknown
      ..writeln('Unknown command.')
      ..writeln('User "help" to know more about supported commands');

    stdout.writeln(unknown.toString());
  }
}
