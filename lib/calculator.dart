import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

/// Simple calculator app with flutter.
class CalculatorApp extends StatelessWidget {
  static const String title = "Calculator";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: CalculatorApp.title,
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new CalculatorWidget(title: CalculatorApp.title),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  CalculatorWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorState createState() => new _CalculatorState();
}

class _CalculatorState extends State<CalculatorWidget> {
  static String _back = new String.fromCharCodes(new Runes("\u25c0"));
  static String _multiply = new String.fromCharCodes(new Runes("\u00d7"));
  static String _divide = new String.fromCharCodes(new Runes("\u00f7"));

  List<List<String>> _calculatorControl;

  ScrollController _scrollController = new ScrollController();

  num _result = 0;

  _CalculatorState() {
    init();
  }

  void init() {
    _calculatorControl = [
      ["7", "8", "9", _multiply],
      ["4", "5", "6", _divide],
      ["1", "2", "3", "+"],
      ["0", ".", "-", "("],
      [_back, "C", "=", ")"]
    ];
  }

  String _calculatorLabel;

  void onPressed(String label) {
    if (label == "=") {
      num result = getResult();

      setState(() {
        _calculatorLabel = result.toString();
      });
    } else if (label == "C") {
      setState(() {
        _calculatorLabel = null;
      });
    } else if (label == _back) {
      setState(() {
        if (_calculatorLabel.length <= 1) {
          _calculatorLabel = null;
        } else {
          _calculatorLabel = _calculatorLabel.substring(0, _calculatorLabel.length - 1);
        }
      });
    } else {
      setState(() {
        _calculatorLabel += label;

        _result = getResult();
      });
    }
  }

  num getResult() {
    Parser p = new Parser();

    num result = 0;

    try {
      Expression exp = p.parse(normalizeCalculation(_calculatorLabel));
      result = exp.evaluate(EvaluationType.REAL, new ContextModel());
    } catch (e) {
      result = _result;
    }

    return result;
  }

  String normalizeCalculation(String str) {
    str = str.replaceAll(_multiply, "*");
    str = str.replaceAll(_divide, "/");

    return str;
  }

  String getCalculatorLabel() {
    if (_calculatorLabel == null) {
      _calculatorLabel = " ";
    } else {
      _calculatorLabel = _calculatorLabel.trim();
    }

    return _calculatorLabel;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: createBody());
  }

  Widget createBody() {
    return new Column(children: getRows());
  }

  List<Widget> getRows() {
    List<Widget> rows = [];

    Text text = new Text(getCalculatorLabel(), textScaleFactor: 3.0, maxLines: 1, style: new TextStyle(fontSize: 20.0), textAlign: TextAlign.center);
    SingleChildScrollView scrollView = new SingleChildScrollView(
        child: new Container(child: text, padding: new EdgeInsets.all(10.0)), scrollDirection: Axis.horizontal, controller: _scrollController, reverse: true);
    rows.add(scrollView);

    Text result = new Text("$_result", textScaleFactor: 2.0, maxLines: 1, style: new TextStyle(fontSize: 14.0), textAlign: TextAlign.right);
    rows.add(new Row(children: [result], mainAxisAlignment: MainAxisAlignment.end));

    int rowCount = _calculatorControl.length;
    for (int i = 0; i < rowCount; i++) {
      List<String> labels = _calculatorControl[i];

      int colCount = labels.length;
      rows.add(new Expanded(
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: new List<Widget>.generate(colCount, (index) {
                String label = labels[index];

                return new Expanded(
                    child: new RaisedButton(
                        onPressed: () {
                          onPressed(label);
                        },
                        child: new Text(label, style: new TextStyle(fontSize: 25.0)),
                        color: index == colCount - 1 ? Colors.amberAccent : Colors.white));
              }))));
    }

    return rows;
  }
}
