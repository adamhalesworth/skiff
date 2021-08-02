import 'package:skiff/src/commands/command.dart';
import 'package:skiff/src/commands/command_result.dart';
import 'package:skiff/src/handler.dart';

/// A marker interface for command handlers.
abstract class CommandHandler<C extends Command>
    implements Handler<C, CommandResult> {}
