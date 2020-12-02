import 'dart:async';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:test/test.dart';

void main() {
  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> Login(bool seguir) async {
    print("Some process...");
    var x;
    for (var i = 0; i < 10; i++) {
      x = 2 * i;
    }

    if (seguir) return Future.error("Error");

    print("End process");
  }

  test("Testing future errors", () {
    Login(true).then((value) => print("Success"),
        onError: (onError) => print("Error"));
  });
}
