import 'dart:async';

import 'package:skiff/src/commands/command.dart';
import 'package:skiff/src/commands/command_handler.dart';
import 'package:skiff/src/commands/command_result.dart';
import 'package:test/test.dart';

class StubCommand implements Command {
  final String username;
  final String password;

  StubCommand({this.username, this.password});

  @override
  String toString() => '$username, ${"*" * password.length}';
}

class StubHandler implements CommandHandler<StubCommand> {
  bool _shouldFail = false;

  void fail() => _shouldFail = true;

  @override
  Future<CommandResult> execute(StubCommand command) {
    return _shouldFail
        ? Future.value(CommandResult.failed(message: 'Something went wrong'))
        : Future.value(CommandResult.succeeded());
  }
}

void main() {
  StubCommand stubCommand;
  StubHandler sut;

  setUp(() {
    stubCommand = StubCommand(username: 'jim.hop', password: 'h0pp3r');
    sut = StubHandler();
  });

  group('StubHandler', () {
    test('.execute() returns successful result', () async {
      var value = await sut.execute(stubCommand);

      expect(value.isSuccessful, equals(true));
    });

    test('.execute() returns failed result', () async {
      sut.fail();

      var value = await sut.execute(stubCommand);

      expect(value.isSuccessful, equals(false));
    });
  });
}
