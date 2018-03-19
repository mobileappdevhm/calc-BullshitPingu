import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/binary_operator.dart';
import 'package:calculator/logic/term/operator/dot_operator.dart';
import 'package:calculator/logic/term/operator/line_operator.dart';
import 'package:calculator/logic/term/operator/operator.dart';
import 'package:calculator/logic/term/term_member.dart';

typedef bool Predicate<T>(T toTest);

/**
 * A term is a mathematical expression which consists of mathematical operators
 * and/or numbers.
 */
class Term implements TermMember {
  static final List<Predicate> _calculationOrder = [(m) => m is Term, (m) => m is DotOperator, (m) => m is LineOperator];

  List<TermMember> members = [];

  num calculate() {
    for (Predicate predicate in _calculationOrder) {
      bool success = true;

      // First and foremost calculate dot operations and then line operations.
      do {
        success = _calcNext(predicate);
      } while (success);
    }

    // There should only be a number left, else the calculation is invalid.
    if (members.length != 1 || members[0] is! NumberMember) {
      throw new CalculationException("Calculation is invalid. There are symbols the calculator does not understand.");
    }

    return (members[0] as NumberMember).value;
  }

  bool _calcNext(Predicate p) {
    for (int i = 0; i < members.length; i++) {
      TermMember member = members[i];

      if (p.call(member)) {
        if (member is BinaryOperator) {
          if (i == 0 || i + 1 >= members.length) {
            throw new CalculationException("Calculation is invalid.");
          }

          NumberMember first = members[i - 1] as NumberMember;
          NumberMember last = members[i + 1] as NumberMember;

          TermMember newMember = member.calculate(first, last);

          _replaceMemberRangeWith(newMember, i - 1, i + 2);
        } else if (member is Term) { // For brackets
          TermMember newMember = new NumberMember(member.calculate());

          _replaceMemberRangeWith(newMember, i, i + 1);
        }

        return true;
      }
    }

    return false;
  }

  void _replaceMemberRangeWith(TermMember member, int start, int end) {
    members.removeRange(start, end);
    members.insert(start, member);
  }

  Term operator +(TermMember member) {
    members.add(member);

    return this;
  }
}

class CalculationException implements Exception {
  String message;

  CalculationException(this.message);
}
