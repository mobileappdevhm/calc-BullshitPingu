import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/term_member.dart';

abstract class Operator implements TermMember {

  NumberMember calculate(NumberMember m1, NumberMember m2);

}