import 'package:firstproject/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
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
  var userQuestion = "";
  var userAnswer = "";
  final myTextStyle = TextStyle(fontSize: 50.0, color: Colors.indigo[900]);
  final displayTextStyle = TextStyle(fontSize: 40.0, color: Colors.white,fontWeight: FontWeight.bold);
  final titleTextStyle = TextStyle(
      fontSize: 30.0, color: Colors.white70, fontWeight: FontWeight.bold);
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
        "Eazy CAL",
        style: titleTextStyle,
      ),
      ),
      backgroundColor: Colors.white12,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: displayTextStyle,
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: displayTextStyle,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                //clear button
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = "";
                        userAnswer = "";
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.greenAccent,
                    textColor: Colors.indigo[900],
                  );
                } //del button
                else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.indigo[900],
                  );
                  //equal button
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.indigo[900],
                    textColor: Colors.white70,
                  );
                } //ans button
                if (index == buttons.length - 2) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.greenAccent,
                    textColor: Colors.indigo[900],
                  );
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.indigo[900]
                        : Colors.indigo[200],
                    textColor: isOperator(buttons[index])
                        ? Colors.white70
                        : Colors.indigo[900],
                  );
                }
              },
            )),
          )
        ],
      ),
    );
  }

  bool isOperator(String operator) {
    if (operator == "%" ||
        operator == "/" ||
        operator == "X" ||
        operator == "-" ||
        operator == "+" ||
        operator == "=") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("X", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
