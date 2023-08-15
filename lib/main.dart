import 'package:flutter/material.dart';
import 'package:flutter_calculator_application/constanst.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  const CalculatorApplication({super.key});

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var inputUser = "";
  var result = "";
  void buttomPressed(String text) {
    setState(
      () {
        inputUser = inputUser + text;
      },
    );
  }

  Widget getRow(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackGroundColor(text1),
          ),
          onPressed: () {
            if (text1 == "ac") {
              setState(() {
                inputUser = "";
                result = "";
              });
            }
            buttomPressed(text1);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: getGroundColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackGroundColor(text2),
          ),
          onPressed: () {
            if (text2 == "ce") {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttomPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: getGroundColor(text2)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackGroundColor(text3),
          ),
          onPressed: () {
            buttomPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: getGroundColor(text3)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackGroundColor(text4),
          ),
          onPressed: () {
            if (text4 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttomPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: getGroundColor(text4)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Calculator Application"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.amber,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.00),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: textGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.00),
                        child: Text(
                          result,
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 62.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow("ac", "ce", "%", "/"),
                      getRow("7", "8", "9", "*"),
                      getRow("4", "5", "6", "-"),
                      getRow("1", "2", "3", "+"),
                      getRow("00", "0", ".", "="),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isOpreator(String text) {
    var list = ["ac", "ce", "%", "/", "*", "-", "+", "="];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }

    return false;
  }

  Color getBackGroundColor(String text) {
    if (isOpreator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getGroundColor(String text) {
    if (isOpreator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
