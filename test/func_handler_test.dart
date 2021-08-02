import 'dart:async';

import 'package:skiff/src/handler.dart';
import 'package:skiff/src/queries/query.dart';
import 'package:test/test.dart';

class StrangerThingsCharacters extends Query {}

void main() {
  test('.execute() executes the given operation', () async {
    var sut =
        FuncHandler<StrangerThingsCharacters, List<String>>((query) async {
      return Future.value(['Jim Hopper', 'Joyce Byers', 'Steve Harrington']);
    });

    var result = await sut.execute(StrangerThingsCharacters());

    expect(result.length, equals(3));
  });
}
