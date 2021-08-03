import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

void main() {
  group('CommandResult', () {
    test('succeeded factory sets successful true', () {
      expect(CommandResult.succeeded().isSuccessful, isTrue);
    });

    test('failed factory sets successful false', () {
      expect(CommandResult.failed().isSuccessful, isFalse);
    });

    test('asFuture returns a completed future', () async {
      var commandFuture =
          await CommandResult.failed(message: 'Something happened').asFuture();

      expect(commandFuture.message, equals('Something happened'));
    });
  });
}
