import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorScreen> {
  String userInput = '';
  String result = '0.0';
  bool dotAdded = false;
  int _themeValue = 2;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userInput = prefs.getString('userInput') ?? '';
      result = prefs.getString('result') ?? '0.0';
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userInput', userInput);
    prefs.setString('result', result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text('Light theme'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('Dark theme'),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text('System theme'),
              ),
            ],
            value: _themeValue,
            onChanged: (value) => _themeChangeCallback(value!),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SelectableText(
                          userInput.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.amber,
                        thickness: 2,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onLongPress: () {
                            final data = ClipboardData(text: result.toString());
                            Clipboard.setData(data);
                          },
                          child: SelectableText(
                            '= $result',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('1'),
                          onPressed: () {
                            userInput += '1';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('2'),
                          onPressed: () {
                            userInput += '2';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('3'),
                          onPressed: () {
                            userInput += '3';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('+'),
                          onPressed: () {
                            handleMathOperation('+');
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('4'),
                          onPressed: () {
                            userInput += '4';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('5'),
                          onPressed: () {
                            userInput += '5';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('6'),
                          onPressed: () {
                            userInput += '6';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('-'),
                          onPressed: () {
                            handleMathOperation('-');
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('7'),
                          onPressed: () {
                            userInput += '7';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('8'),
                          onPressed: () {
                            userInput += '8';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurple[900],
                          child: const Text('9'),
                          onPressed: () {
                            userInput += '9';
                            setState(() {});
                          }),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('x'),
                          onPressed: () {
                            handleMathOperation('x');
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('.'),
                          onPressed: () {
                            if (!dotAdded) {
                              if (userInput.isEmpty) {
                                userInput += '0.';
                              } else {
                                userInput += '.';
                              }
                              dotAdded = true;
                            }
                            setState(() {});
                          }),
                      CustomButton(
                        color: Colors.deepPurple[900],
                        child: const Text('0'),
                        onPressed: () {
                          if (!(userInput == '0')) {
                            userInput += '0';
                            setState(() {});
                          }
                        },
                      ),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('%'),
                          onPressed: () {
                            handleMathOperation('%');
                          }),
                      CustomButton(
                        color: Colors.amber,
                        child: const Text('='),
                        onPressed: () {
                          equalPress();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        color: Colors.redAccent,
                        child: const Text('←'),
                        onPressed: () {
                          if (userInput.isNotEmpty) {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          }
                          setState(() {});
                        },
                        onLongPress: () {
                          userInput = '';
                          result = '0.0';
                          setState(() {});
                        },
                      ),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('/'),
                          onPressed: () {
                            handleMathOperation('/');
                          }),
                      CustomButton(
                          color: Colors.deepPurpleAccent,
                          child: const Text('^'),
                          onPressed: () {
                            handleMathOperation('^');
                          }),
                      CustomButton(
                        color: Colors.red,
                        child: const Text('AC'),
                        onPressed: () {
                          userInput = '';
                          result = '0.0';
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  bool isMathOperation(String character) {
    return ['+', '-', 'x', '/', '^', '%'].contains(character);
  }

  void handleMathOperation(String operation) {
    dotAdded = false;
    if (userInput.isEmpty) {
      return;
    }
    if (userInput.endsWith('^') && operation == '-') {
      userInput += operation;
    } else if (userInput.endsWith('^-')) {
      userInput = userInput.substring(0, userInput.length - 2) + operation;
    } else if (isMathOperation(userInput[userInput.length - 1])) {
      userInput = userInput.substring(0, userInput.length - 1) + operation;
    } else {
      userInput += operation;
    }
    setState(() {
      _saveData();
    });
  }

  void equalPress() {
    dotAdded = false;

    String finalizeInput = userInput.replaceAll('x', '*');
    Parser parser = Parser();
    try {
      Expression expression = parser.parse(finalizeInput);
      ContextModel contextModel = ContextModel();
      dynamic evalute = expression.evaluate(EvaluationType.REAL, contextModel);
      result = evalute.toString();
    } catch (e) {
      result = '0.0';
    }
    setState(() {
      _saveData();
    });
  }

  void _themeChangeCallback(int index) {
    setState(() {
      switch (index) {
        case 1:
          AdaptiveTheme.of(context).setLight();
        case 2:
          AdaptiveTheme.of(context).setDark();
        case 3:
          AdaptiveTheme.of(context).setSystem();
        default:
      }
      _themeValue = index;
    });
  }
}
