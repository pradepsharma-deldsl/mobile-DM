import 'package:flutter_test/flutter_test.dart';
import 'package:secure_doc_mobile/main.dart';

void main() {
  test('root app widget can be constructed', () {
    expect(const SecureDocApp(), isA<SecureDocApp>());
  });
}
