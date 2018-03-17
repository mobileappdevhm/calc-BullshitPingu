import 'package:calculator/logic/term/operator/operator.dart';
import 'package:calculator/logic/term/term.dart';

class AdditionOperator extends Operator {

  AdditionOperator(Term first, Term last) : super(first, last);

  @override
  num calculate() {
    return first.calculate() + last.calculate();
  }

}