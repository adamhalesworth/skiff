import 'dart:async';

import 'package:skiff/src/commands.dart';
import 'package:test/test.dart';

class StubCommand extends Command {
  final String username;
  final String password;

  StubCommand({this.username, this.password});

  @override
  String toString() => '${username}, ${"*" * password.length}';
}

class StubCommandHandler implements CommandHandler<StubCommand> {
  bool _shouldFail = false;

  void fail() => _shouldFail = true;

  @override
  Future<CommandResult> execute(StubCommand command) {
    return _shouldFail
        ? Future.value(CommandResult.failed('Something went wrong'))
        : Future.value(CommandResult.succeeded());
  }
}

void main() {
  StubCommand stubCommand;
  StubCommandHandler sut;

  setUp(() {
    stubCommand = StubCommand(username: 'jim.hop', password: 'h0pp3r');
    sut = StubCommandHandler();
  });

  group('StubCommandHandler', () {
    test('.execute() returns successful result', () async {
      // when
      var value = await sut.execute(stubCommand);

      // then
      expect(value.isSuccessful, equals(true));
    });

    test('.execute() returns failed result', () async {
      // given
      sut.fail();

      // when
      var value = await sut.execute(stubCommand);

      // then
      expect(value.isSuccessful, equals(false));
    });
  });
}
