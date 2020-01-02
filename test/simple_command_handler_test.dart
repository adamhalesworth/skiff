import 'package:skiff/src/commands.dart';
import 'package:test/test.dart';

import 'command_handler_test.dart';

void main() {
  test('.execute() executes the given operation', () async {
    // given
    var sut = SimpleCommandHandler<StubCommand>((command) async {
      expect(command.username, equals('jim.hop'));
      expect(command.password, equals('h0pp3r'));
      return CommandResult.succeeded().asFuture();
    });

    // when
    var result =
        await sut.execute(StubCommand(username: 'jim.hop', password: 'h0pp3r'));

    // then
    expect(result.isSuccessful, equals(true));
  });
}
