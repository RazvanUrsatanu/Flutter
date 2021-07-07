import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number;
  int aux;
  String wrong;
  String button = 'Guess';
  final TextEditingController textControler = TextEditingController();
  static Random ran = Random();
  int randomNumber = ran.nextInt(100) + 1;

  void guess() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text('I am thinking of a number between'),
              const Text('1 to 100'),
              const Text('It is your turn to guess my number'),
              if (wrong != null && number != -1)
                Text(
                  wrong,
                  textScaleFactor: 2,
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 50.00,
                  shadowColor: Colors.purple,
                  child: TextField(
                      controller: textControler,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (String x) {
                        number = int.parse(x);
                      }),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(button),
                    onPressed: () {
                      setState(
                        () {
                          button = 'Guess';
                        },
                      );
                      if (number > randomNumber) {
                        setState(
                          () {
                            wrong = 'You tried ' + number.toString() + ', Try lower';
                          },
                        );
                      } else if (number < randomNumber) {
                        setState(
                          () {
                            wrong = 'You tried ' + number.toString() + ', Try higher';
                          },
                        );
                      } else {
                        setState(
                          () {
                            wrong = 'You tried ' + number.toString() + '\n' + ' You guessed right.';
                          },
                        );
                        return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('You guessed right'),
                            content: Text('It was ' + number.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      wrong = null;
                                      textControler.clear();
                                      ran = Random();
                                      randomNumber = ran.nextInt(100) + 1;
                                      number = -1;
                                    },
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Try again'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      wrong = null;
                                      button = 'Reset';
                                      textControler.clear();
                                      ran = Random();
                                      randomNumber = ran.nextInt(100) + 1;
                                      number = -1;
                                    },
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
