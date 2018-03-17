import 'package:calculator/logic/term/term.dart';

/// An operator has two parts which form the result when concatenated with the operator.
abstract class Operator implements Term {

  Term first;
  Term last;

  Operator(this.first, this.last);

}
