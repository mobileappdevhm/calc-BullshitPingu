import 'package:calculator/logic/term/number_member.dart';
import 'package:calculator/logic/term/operator/addition_operator.dart';
import 'package:calculator/logic/term/operator/division_operator.dart';
import 'package:calculator/logic/term/operator/multiplication_operator.dart';
import 'package:calculator/logic/term/operator/subtraction_operator.dart';
import 'package:calculator/logic/term/term.dart';

class TermUtil {
  static const int multiplication = 42;
  static const int division = 47;
  static const int addition = 43;
  static const int subtraction = 45;

  /// Get term from string.
  static Term from(String str) {
    Term term = new Term();

    List<int> buffer = [];
    for (int i = 0; i < str.length; i++) {
      final int codeUnit = str.codeUnitAt(i);

      switch (codeUnit) {
        case multiplication:
          _addNumberToTerm(buffer, term);
          term = term + new MultiplicationOperator();
          break;

        case division:
          _addNumberToTerm(buffer, term);
          term = term + new DivisionOperator();
          break;

        case addition:
          _addNumberToTerm(buffer, term);
          term = term + new AdditionOperator();
          break;

        case subtraction:
          _addNumberToTerm(buffer, term);
          term = term + new SubtractionOperator();
          break;

        default:
          buffer.add(codeUnit);
      }
    }

    if (buffer.length != 0) {
      _addNumberToTerm(buffer, term);
    }

    return term;
  }

  static void _addNumberToTerm(List<int> buffer, Term term) {
    String numberString = new String.fromCharCodes(buffer);
    term = term + new NumberMember(num.parse(numberString));

    buffer.clear();
  }

}
