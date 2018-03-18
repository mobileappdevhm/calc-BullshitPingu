import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/line_operator.dart';

class SubtractionOperator extends LineOperator {

  @override
  NumberMember calculate(NumberMember m1, NumberMember m2) {
    return m1 - m2;
  }

}
