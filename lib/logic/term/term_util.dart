import 'package:calculator/logic/term/number_term.dart';
import 'package:calculator/logic/term/operator/addition_operator.dart';
import 'package:calculator/logic/term/operator/division_operator.dart';
import 'package:calculator/logic/term/operator/multiplication_operator.dart';
import 'package:calculator/logic/term/operator/subtraction_operator.dart';
import 'package:calculator/logic/term/term.dart';

typedef Term _TermGenerator(_TermSupplier left, _TermSupplier right);
typedef Term _TermSupplier();

class TermUtil {
  static const int multiplication = 42;
  static const int division = 47;
  static const int addition = 43;
  static const int subtraction = 45;

  static List<Map<int, _TermGenerator>> splitOrder = [
    {
      multiplication: (firstTermSupplier, lastTermSupplier) => new MultiplicationOperator(firstTermSupplier.call(), lastTermSupplier.call()),
      division: (firstTermSupplier, lastTermSupplier) => new DivisionOperator(firstTermSupplier.call(), lastTermSupplier.call())
    },
    {
      addition: (firstTermSupplier, lastTermSupplier) => new AdditionOperator(firstTermSupplier.call(), lastTermSupplier.call()),
      subtraction: (firstTermSupplier, lastTermSupplier) => new SubtractionOperator(firstTermSupplier.call(), lastTermSupplier.call())
    }
  ];

  /// Get term from string.
  static Term from(String str) {
    return _splitBy(str, splitOrder, 0);
  }

  static Term _splitBy(String str, List<Map<int, _TermGenerator>> splitter, int splitterIndex) {
    if (splitterIndex >= splitter.length) {
      return new NumberTerm(num.parse(str));
    }

    Map<int, _TermGenerator> splitterMap = splitter[splitterIndex];

    Term term;
    for (int i = str.length - 1; i >= 0; i--) {
      final int codeUnit = str.codeUnitAt(i);

      _TermGenerator generator = splitterMap[codeUnit];

      if (generator != null) {
        term = generator.call(
            () => _splitBy(str.substring(0, i), splitter, splitterIndex), () => _splitBy(str.substring(i + 1, str.length), splitter, splitterIndex + 1));
        break;
      }
    }

    if (term == null) {
      term = _splitBy(str, splitter, splitterIndex + 1);
    }

    return term;
  }
}
