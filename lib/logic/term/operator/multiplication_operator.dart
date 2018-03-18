import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/dot_operator.dart';

class MultiplicationOperator extends DotOperator {

  @override
  NumberMember calculate(NumberMember m1, NumberMember m2) {
    return m1 * m2;
  }

}
