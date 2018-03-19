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

  static const int open_bracket = 40;
  static const int closed_bracket = 41;

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

        case open_bracket:
          i = _addBracketToTerm(term, str, i);
          break;

        case closed_bracket:
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
    if (buffer.length != 0) {
      String numberString = new String.fromCharCodes(buffer);
      term = term + new NumberMember(num.parse(numberString));

      buffer.clear();
    }
  }

  /// Add complete bracket to term and return the new position.
  static int _addBracketToTerm(Term term, String str, int startPos) {
    // Find bracket end
    int openBracketCount = 0;
    for (int i = startPos + 1; i < str.length; i++) {
      final int codeUnit = str.codeUnitAt(i);

      switch (codeUnit) {
        case open_bracket:
          openBracketCount++;
          break;

        case closed_bracket:
          if (openBracketCount == 0) {
            Term bracketTerm = TermUtil.from(str.substring(startPos + 1, i));
            term = term + bracketTerm;

            return i;
          } else {
            openBracketCount--;
          }
          break;

        default:
      }
    }

    return startPos;
  }

}
