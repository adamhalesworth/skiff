import 'dart:async';

import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

class StrangerThingsCharacters extends Query {}

void main() {
  test('.get() executes the given operation', () async {
    // given
    var sut = SimpleQueryHandler<StrangerThingsCharacters, List<String>>(
        (query) async {
      return Future.value(['Jim Hopper', 'Joyce Byers', 'Steve Harrington']);
    });

    // when
    var result = await sut.get(StrangerThingsCharacters());

    // then
    expect(result.length, equals(3));
  });
}
