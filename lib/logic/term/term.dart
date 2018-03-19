import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/dot_operator.dart';
import 'package:calculator/logic/term/operator/line_operator.dart';
import 'package:calculator/logic/term/operator/operator.dart';
import 'package:calculator/logic/term/term_member.dart';

typedef bool Predicate<T>(T toTest);

/**
 * A term is a mathematical expression which consists of mathematical operators
 * and/or numbers.
 */
class Term {

  List<TermMember> members = [];

  num calculate() {
    bool success = true;

    // First and foremost calculate dot operations and then line operations.
    do {
      success = _calcNext((operator) => operator is DotOperator);
    } while (success);

    success = true;
    // Now the line operations.
    do {
      success = _calcNext((operator) => operator is LineOperator);
    } while (success);

    // There should only be a number left, else the calculation is invalid.
    if (members.length != 1 || members[0] is! NumberMember) {
      throw new CalculationException("Calculation is invalid. There are symbols the calculator does not understand.");
    }

    return (members[0] as NumberMember).value;
  }

  bool _calcNext(Predicate p) {
    for (int i = 0; i < members.length; i++) {
      TermMember member = members[i];

      if (member is Operator && p.call(member)) {
        if (i == 0 || i + 1 >= members.length) {
          throw new CalculationException("Calculation is invalid.");
        }

        NumberMember first = members[i - 1] as NumberMember;
        NumberMember last = members[i + 1] as NumberMember;

        TermMember newMember = member.calculate(first, last);

        members.removeRange(i - 1, i + 2);
        members.insert(i - 1, newMember);

        return true;
      }
    }

    return false;
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