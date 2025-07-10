import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> longPrint() async {
    await Future.delayed(Duration(seconds: 2), () {
      var a = 4;
      final b = a;
      a = 3;
      print("two: $a and $b");
    });
  }

  Future<void> testAsync() async {
    print("one");
    await longPrint();
    print("three");
  }

  test('Async test', () async {
    await testAsync();
  });
}