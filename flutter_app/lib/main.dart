import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String amount = '';
  String wrong = '';
  double res = 0;
  bool b = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency convertor'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Image.network('https://www.tellermate.com/us/wp-content/uploads/sites/8/2020/05/Cash-US-1024x512.jpg'),
          TextField(
              decoration: InputDecoration(hintText: 'Enter the amount in EUR', errorText: wrong),
              onChanged: (String s) {
                amount = s;
              }),
          ElevatedButton(
              child: const Text('Convert'),
              onPressed: () {
                if (amount == null) {
                  setState(
                    () {
                      wrong = 'please enter a number';
                    },
                  );
                } else {
                  try {
                    setState(() {
                      res = 4.5 * double.parse(amount);
                      b = true;
                      wrong = '';
                    });
                  } on FormatException {
                    setState(
                      () {
                        wrong = 'please enter a number';
                      },
                    );
                  }
                }
              }),
          Text(
            b == true ? '${res.toStringAsFixed(2)} RON' : '',
            textScaleFactor: 2,
          )
        ],
      ),
    );
  }
}
