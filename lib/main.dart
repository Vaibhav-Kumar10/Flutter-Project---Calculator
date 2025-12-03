import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'CLC',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  var userQuestion = '', userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          // Input area
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(userQuestion, style: TextStyle(fontSize: 24.0)),
                ),

                SizedBox(height: 40.0),

                Container(
                  padding: EdgeInsets.all(18.0),
                  alignment: Alignment.centerRight,
                  child: Text(userAnswer, style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ),

          // Buttons
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // CLEAR button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                      btnColor: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }
                  // DEL button
                  else if (index == 1) {
                    if (userQuestion.isEmpty) {
                      return MyButton(
                        buttonTapped: () {},
                        btnColor: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      );
                    }
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                            0,
                            userQuestion.length - 1,
                          );
                        });
                      },
                      btnColor: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }
                  // = button
                  else if (index == buttons.length - 1) {
                    if (userQuestion.isEmpty) {
                      return MyButton(
                        buttonTapped: () {},
                        btnColor: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      );
                    }
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          calculate();
                        });
                      },
                      btnColor: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }
                  // ANS button
                  else if (index == buttons.length - 2) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += userAnswer;
                        });
                      },
                      btnColor: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }
                  // Other buttons
                  else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      btnColor: isOperator(buttons[index])
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                      buttonText: buttons[index],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "X" || x == "/" || x == "+" || x == "-" || x == "%" || x == "=") {
      return true;
    }
    return false;
  }

  void calculate() {
    // Calculation logic will be implemented here
    String question = userQuestion.replaceAll('X', '*');
    Parser p = Parser();
    Expression exp = p.parse(question);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
