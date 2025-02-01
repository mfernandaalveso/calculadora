import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Calculadora'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "0";
  String expression = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        result = evaluateExpression(expression);
      } else if (value == "C") {
        result = "0";
        expression = "";
      } else {
        if (expression == "0") {
          expression = value;
        } else {
          expression += value;
        }
        result = expression;
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      // Substituindo os sinais para criar uma expressão válida em Dart
      expression = expression.replaceAll('x', '*').replaceAll('÷', '/');
      final double? value = _evaluate(expression);
      if (value != null) {
        return value.toString();
      } else {
        return "Erro";
      }
    } catch (e) {
      return "Erro";
    }
  }

  double? _evaluate(String expression) {
    try {
      // Usando a expressão Dart para calcular (isso ainda não é tão robusto como um parser completo)
      final result = double.tryParse(expression);
      if (result != null) return result;

      // Calculando o valor da expressão
      final regex = RegExp(r'(\d+(\.\d+)?)\s*([+\-*/])\s*(\d+(\.\d+)?)');
      final matches = regex.firstMatch(expression);

      if (matches != null) {
        final num1 = double.parse(matches.group(1)!);
        final operator = matches.group(3);
        final num2 = double.parse(matches.group(4)!);

        switch (operator) {
          case "+":
            return num1 + num2;
          case "-":
            return num1 - num2;
          case "*":
            return num1 * num2;
          case "/":
            return num2 != 0 ? num1 / num2 : double.nan;
          default:
            return null;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display result
          Text(
            result,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // Button Grid
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 16,
            itemBuilder: (context, index) {
              String buttonLabel;
              switch (index) {
                case 0:
                  buttonLabel = "7";
                  break;
                case 1:
                  buttonLabel = "8";
                  break;
                case 2:
                  buttonLabel = "9";
                  break;
                case 3:
                  buttonLabel = "÷";
                  break;
                case 4:
                  buttonLabel = "4";
                  break;
                case 5:
                  buttonLabel = "5";
                  break;
                case 6:
                  buttonLabel = "6";
                  break;
                case 7:
                  buttonLabel = "x";
                  break;
                case 8:
                  buttonLabel = "1";
                  break;
                case 9:
                  buttonLabel = "2";
                  break;
                case 10:
                  buttonLabel = "3";
                  break;
                case 11:
                  buttonLabel = "-";
                  break;
                case 12:
                  buttonLabel = "0";
                  break;
                case 13:
                  buttonLabel = "=";
                  break;
                case 14:
                  buttonLabel = "+";
                  break;
                case 15:
                  buttonLabel = "C";
                  break;
                default:
                  buttonLabel = "";
              }
              return ElevatedButton(
                onPressed: () => onButtonPressed(buttonLabel),
                child: Text(buttonLabel, style: TextStyle(fontSize: 24)),
              );
            },
          ),
        ],
      ),
    );
  }
}


