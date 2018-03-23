import 'package:calculator/logic/term/term.dart';
import 'package:calculator/logic/term/term_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test simple calculation", () {
    Term term = TermUtil.from("1+1");

    expect(term.calculate(), 2.0);
  });
}