import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/operator.dart';

abstract class BinaryOperator extends Operator {

  NumberMember calculate(NumberMember m1, NumberMember m2);

}