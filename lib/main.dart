import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '0';
  String input = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        result = '0';
      } else if (buttonText == '=') {
        try {
          result = _calculateResult(input);
        } catch (e) {
          result = 'Erro';
        }
      } else {
        input += buttonText;
      }
    });
  }

  String _calculateResult(String input) {
    // Substituindo operadores para uso com o package 'expressions'
    input = input.replaceAll('×', '*').replaceAll('÷', '/');
    return _evaluateExpression(input).toString();
  }

  double _evaluateExpression(String expression) {
    // Aqui você pode adicionar um parser para a expressão
    // Para simplicidade, usamos a função eval do package 'expressions'
    // Adicione o package 'expressions' no seu pubspec.yaml
    return double.parse(expression); // Simplificado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora')),
      body: Column(
        children: [
          Expanded(child: Container()),
          Text(
            input,
            style: TextStyle(fontSize: 40),
          ),
          Text(
            result,
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('÷'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('×'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(fontSize: 30)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          primary: Colors.blue,
        ),
      ),
    );
  }
}

