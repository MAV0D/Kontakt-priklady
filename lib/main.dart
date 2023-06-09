import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  generateProblem();

  runApp(const MyApp());
}

var resController = TextEditingController();
var result = "";
int resultInt = 0;
int spravneOdpovedi = 0;
const int potrebneOdpovedi = 5;
int a = 0;
int b = 0;
int znamenkoInt = 0;
var znamenkoZnak = ' ';
var delitele = [];
int nDelitelu = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(
          title:
              'Vypočítejte příklady pro posun k pochopení problému tří těles:'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode _polickoOdpovediFocusInput = FocusNode();

  final FocusNode _dialogFocusNode = FocusNode();

  void refresh() {
    setState(() {
      resChecker();
      var zprava = "";
      switch (spravneOdpovedi) {
        case (potrebneOdpovedi):
          {
            zprava = "Pokrok! Blížíte se ke správnému výpočtu.";
            break;
          }
        case potrebneOdpovedi * 2:
          {
            zprava =
                "Zdá se, že chaotická éra a stabilní éra se střídají nepravidelně.";
            break;
          }
        case potrebneOdpovedi * 3:
          {
            zprava = "Ve stabilních érách trvá den a noc stejně dlouho.";
            break;
          }
        case potrebneOdpovedi * 4:
          {
            zprava =
                "V některých okamžicích se objeví až tři slunce na obloze zároveň.";
            break;
          }
        case potrebneOdpovedi * 5:
          {
            zprava =
                "Výpočty jsou hotové. Tento problém nemá řešení. Není možné spočítat, kdy bude stabilní a kdy chaotická éra.";
            break;
          }
        default:
          {
            break;
          }
      }
      if (spravneOdpovedi % potrebneOdpovedi == 0 && spravneOdpovedi != 0) {
        _dialogFocusNode.requestFocus();

        final snackBar = SnackBar(
            content: Text(zprava, style: TextStyle(fontSize: 40)),
            duration: const Duration(seconds: 10));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pink = Color.fromARGB(255, 255, 180, 180);
    final blue = Color.fromARGB(255, 152, 208, 229);
    final Color textColor = (Random().nextInt(99) % 2 == 0) ? pink : blue;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 199, 199),
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        centerTitle: true,
        toolbarHeight: 120,
        title: Container(
            width: 750,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            child: LinearProgressIndicator(
              minHeight: 50,
              backgroundColor: Colors.white,
              value: ((spravneOdpovedi % potrebneOdpovedi) / potrebneOdpovedi),
            )),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$a $znamenkoZnak $b = ',
              style: TextStyle(
                color: textColor,
                fontSize: 80,
              )),
          SizedBox(
            width: 240,
            height: 140,
            child: TextField(
                onSubmitted: (value) {
                  refresh();
                  _polickoOdpovediFocusInput.requestFocus();
                },
                autofocus: true,
                focusNode: _polickoOdpovediFocusInput,
                controller: resController,
                style: const TextStyle(fontSize: 80),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                )),
          )
        ],
      )),
      // floatingActionButton: SizedBox(
      //     height: 100,
      //     width: 100,
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.yellow[900],
      //       onPressed: () {
      //         refresh();
      //       },
      //       tooltip: 'Ověřit výsledek',
      //       child: const Icon(
      //         Icons.check,
      //         size: 100,
      //       ),
      //     ))
    );
  }
}

void resChecker() {
  result = resController.text;
  try {
    resultInt = int.parse(result);
  } catch (e) {
    resultInt = 0;
  }
  switch (znamenkoZnak) {
    case '+':
      {
        if (a + b == resultInt) {
          spravneOdpovedi++;
          generateProblem();
        }
        break;
      }
    case '-':
      {
        if (a - b == resultInt) {
          spravneOdpovedi++;
          generateProblem();
        }
        break;
      }
    case '*':
      {
        if (a * b == resultInt) {
          spravneOdpovedi++;
          generateProblem();
        }
        break;
      }
    case '/':
      {
        if ((a / b).round() == resultInt) {
          spravneOdpovedi++;
          generateProblem();
        }
        break;
      }
    default:
      {
        generateProblem();
        break;
      }
  }
  resController.clear();
}

void generateProblem() {
  a = 0;
  b = 0;
  delitele = [];
  nDelitelu = 0;
  znamenkoInt = Random().nextInt(4);
  if (spravneOdpovedi < potrebneOdpovedi * 4) {
    const maximalniCislo = 10
    switch (znamenkoInt) {
      case 0:
        {
          znamenkoZnak = "+";
          a = Random().nextInt(maximalniCislo) + 1;
          b = Random().nextInt(maximalniCislo) + 1;
        }
        break;

      case 1:
        {
          znamenkoZnak = "-";
          a = Random().nextInt(maximalniCislo) + 1;
          b = Random().nextInt(a - 1) + 1;
        }
        break;

      case 2:
        {
          znamenkoZnak = "*";
          a = Random().nextInt(maximalniCislo) + 1;
          b = Random().nextInt(10) + 1;
        }
        break;

      case 3:
        {
          znamenkoZnak = "/";
          while (nDelitelu == 0) {
            a = Random().nextInt(maximalniCislo) + 1;
            delitele = [];
            nDelitelu = 0;
            for (var i = 2; i < sqrt(a); i++) {
              if (a % i == 0) {
                delitele.add(i);
                nDelitelu++;
                if (a / i != i) {
                  delitele.add((a / i).round());
                  nDelitelu++;
                }
              }
            }
          }
          b = delitele[Random().nextInt(nDelitelu)];
        }
        break;
    }
  } else {
    znamenkoZnak = "0";
  }
}
