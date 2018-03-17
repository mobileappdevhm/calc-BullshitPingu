import 'package:calculator/logic/term/term.dart';

class NumberTerm implements Term {

  final num value;

  NumberTerm(this.value);

  @override
  num calculate() {
    return value;
  }

}