import 'package:skiff/src/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('MediatorException', () {
    test('toString returns correct stringified exception message', () {
      var exception = RequestTypeMissingException();
      expect(exception.toString(),
          'RequestTypeMissingException: Missing required request type');
    });
  });
}
