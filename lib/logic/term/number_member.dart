import 'package:calculator/logic/term/term_member.dart';

class NumberMember implements TermMember {

  final num value;

  NumberMember(this.value);

  @override
  NumberMember operator +(NumberMember other) {
    return new NumberMember(value + other.value);
  }

  @override
  NumberMember operator -(NumberMember other) {
    return new NumberMember(value - other.value);
  }

  @override
  NumberMember operator *(NumberMember other) {
    return new NumberMember(value * other.value);
  }

  @override
  NumberMember operator /(NumberMember other) {
    return new NumberMember(value / other.value);
  }

}