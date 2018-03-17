import 'package:calculator/logic/term/term.dart';
import 'package:calculator/logic/term/term_util.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculator',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<List<String>> _calculatorControl = [
    ["9", "8", "7", "*"],
    ["6", "5", "4", "/"],
    ["3", "2", "1", "+"],
    [".", "0", "C", "="]
  ];

  String _calculatorLabel;

  void onPressed(String label) {
    switch (label) {
      case "=":
        Term term = TermUtil.from(_calculatorLabel);

        num result = 0;
        if (term != null) {
          result = term.calculate();
        }

        setState(() {
          _calculatorLabel = result.toString();
        });
        break;

      case "C":
        setState(() {
          _calculatorLabel = null;
        });
        break;

      default:
        setState(() {
          _calculatorLabel += label;
        });
    }
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
        ),
        body: createBody());
  }

  Widget createBody() {
    return new Column(children: getRows());
  }

  List<Widget> getRows() {
    List<Widget> rows = [];

    Text text = new Text(getCalculatorLabel(), textScaleFactor: 4.0, maxLines: 1, overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 20.0), textAlign: TextAlign.center);
    rows.add(new Container(child: text, padding: new EdgeInsets.all(10.0)));

    int rowCount = _calculatorControl.length;
    for (int i = 0; i < rowCount; i++) {
      List<String> labels = _calculatorControl[i];

      int colCount = labels.length;
      rows.add(new Expanded(child: new Row(crossAxisAlignment: CrossAxisAlignment.stretch,children: new List<Widget>.generate(colCount, (index) {
        String label = labels[index];

        return new Expanded(child: new RaisedButton(onPressed: () {
          onPressed(label);
        }, child: new Text(label)));
      }))));
    }

    return rows;
  }

}
