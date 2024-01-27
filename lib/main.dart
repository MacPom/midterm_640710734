import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";

  static const addSign = "\u002B";
  static const subtractSign = "\u2212";
  static const multiplySign = "\u00D7";
  static const divideSign = "\u00F7";
  static const equalSign = "\u003D";

  void updateDisplay(String value) {
    setState(() {
      if (displayText == "0" || displayText == "Error") {
        displayText = value;
      } else {
        displayText += value;
      }
    });
  }

  void clearDisplay() {
    setState(() {
      displayText = "0";
    });
  }

  void backspace() {
    setState(() {
      if (displayText.length > 1) {
        displayText = displayText.substring(0, displayText.length - 1);
      } else {
        displayText = "0";
      }
    });
  }

  void calculateResult() {
    setState(() {
      displayText = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          buildRow([clearButton(), backspaceButton()]),
          buildRow([
            numberButton("7"),
            numberButton("8"),
            numberButton("9"),
            operatorButton(divideSign)
          ]),
          buildRow([
            numberButton("4"),
            numberButton("5"),
            numberButton("6"),
            operatorButton(multiplySign)
          ]),
          buildRow([
            numberButton("1"),
            numberButton("2"),
            numberButton("3"),
            operatorButton(subtractSign)
          ]),
          buildRow([numberButton("0"), operatorButton(addSign)]),
          buildRow([operatorButton(equalSign)]),
        ],
      ),
    );
  }

  Widget buildRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons,
      ),
    );
  }

  Widget numberButton(String value) {
    return value == "0"
        ? Flexible(
            flex: 3,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: GestureDetector(
                onTap: () => updateDisplay(value),
                child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Flexible(
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: GestureDetector(
                onTap: () => updateDisplay(value),
                child: Container(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget operatorButton(String value) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: GestureDetector(
          onTap: () {
            if (value == equalSign) {
              calculateResult();
            } else {
              updateDisplay(value);
            }
          },
          child: Container(
            color: value == equalSign ? Colors.green[700] : Colors.grey,
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clearButton() {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: GestureDetector(
          onTap: clearDisplay,
          child: Container(
            color: Colors.grey,
            child: Center(
              child: Text(
                "C",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget backspaceButton() {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: GestureDetector(
          onTap: () => backspace(),
          child: Container(
            color: Colors.grey,
            child: Center(
              child: Icon(Icons.backspace),
            ),
          ),
        ),
      ),
    );
  }
}
