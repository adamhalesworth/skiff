import 'package:mocktail/mocktail.dart';
import 'package:skiff/src/event.dart';

class MockEventCallback extends Mock {
  dynamic call(Event e);
}
