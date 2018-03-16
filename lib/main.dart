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

  List<String> _labels = [];
  List<Function> _functions = [];

  String _calculatorLabel;

  _MyHomePageState() {
    for (int i = 0; i <= 8; i++) {
      _labels.add((9 - i).toString());
      _functions.add(() => onNumPressed(9 - i));
    }

    _labels.add("+");
    _functions.add(() => onAddPressed());

    _labels.add("0");
    _functions.add(() => onNumPressed(0));

    _labels.add("-");
    _functions.add(() => onSubtractPressed());

    _labels.add("*");
    _functions.add(() => onMultiplyPressed());

    _labels.add("/");
    _functions.add(() => onDividePressed());

    _labels.add("=");
    _functions.add(() => onEqualsPressed());
  }

  void onNumPressed(int number) {
    setState(() {
      _calculatorLabel = _calculatorLabel + number.toString();
    });
  }

  void onAddPressed() {

  }

  void onSubtractPressed() {

  }

  void onMultiplyPressed() {

  }

  void onDividePressed() {

  }

  void onEqualsPressed() {
    setState(() {
      _calculatorLabel = null;
    });
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

    rows.add(new Container(child: new Text(getCalculatorLabel(), textScaleFactor: 2.0, maxLines: 1, overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 20.0), textAlign: TextAlign.center), padding: new EdgeInsets.all(10.0)));

    int rowCount = (_labels.length / 3).round();
    for (int i = 0; i < rowCount; i++) {
      rows.add(new Expanded(child: new Row(crossAxisAlignment: CrossAxisAlignment.stretch,children: new List<Widget>.generate(3, (index) {
        int a = i * 3 + index;
        String label = _labels[a];
        Function func = _functions[a];

        return new Expanded(child: new RaisedButton(onPressed: func, child: new Text(label)));
      }))));
    }

    return rows;
  }

}
