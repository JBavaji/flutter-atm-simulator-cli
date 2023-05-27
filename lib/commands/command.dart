import 'package:args/args.dart';

abstract class Command {
  String name = "unknown";
  String description = 'unknown-description';

  execute(ArgResults results);
}
