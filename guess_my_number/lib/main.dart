import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number;
  int aux;
  String wrong;
  String button = 'Guess';
  final textControler = TextEditingController();
  static Random ran = new Random();
  int randomNumber = ran.nextInt(100) + 1;

  void guess() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guess my number"),
        centerTitle: true,
      ),
      body: Container (
        child: Column (
          children: [
            Text("I'm thinking of a number between"),
            Text("1 to 100"),
            Text("It's your turn to guess my number"),
            if(wrong != null && number != -1)
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
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  ),
                    onChanged: (String x) {
                      number = int.parse(x);
                    }
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    child: Text(button),
                    onPressed: () {
                      setState(() {
                        button = 'Guess';
                      },);
                      if (number > randomNumber) {
                        setState(() {
                          wrong = 'You tried ' + number.toString() + ', Try lower';
                        },);
                      } else if (number < randomNumber) {
                        setState(() {
                          wrong = 'You tried ' + number.toString() + ', Try higher';
                        },);
                      } else {
                        setState(() {
                          wrong = 'You tried ' + number.toString() + '\n' + ' You guessed right.';
                        },);
                        return showDialog(
                        context: context,
                          builder:(context)=>  AlertDialog(
                          title: Text('You guessed right'),
                          content: Text("It was " + number.toString()),
                          actions: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                setState(() {
                                  wrong = null;
                                  textControler.clear();
                                  ran = new Random();
                                  randomNumber = ran.nextInt(100) + 1;
                                  number = -1;
                                },);
                                Navigator.of(context).pop();
                              },
                              child: Text('Try again'),
                            ),
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                setState(() {
                                  wrong = null;
                                  button = 'Reset';
                                  textControler.clear();
                                  ran = new Random();
                                  randomNumber = ran.nextInt(100) + 1;
                                  number = -1;
                                },);
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
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
      ),
    );
  }
}
