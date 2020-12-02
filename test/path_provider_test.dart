import 'dart:io';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:path_provider/path_provider.dart';
import 'package:test/test.dart';

void main() {
  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();

  test("Testing path provider", () async {
    flutter_test.expect(await getTemporaryDirectory(), Directory);
  });
}
