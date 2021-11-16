import 'package:skiff/src/commands/command_result.dart';
import 'package:skiff/src/request.dart';

/// A marker interface for commands.
abstract class Command implements Request<CommandResult> {}
