import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var resController = TextEditingController();
var result = "";
int resultInt = 0;
int spravneOdpovedi = 0;
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
  void refresh() {
    setState(() {
      resChecker();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          centerTitle: true,
          title: Container(
              width: 750,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: LinearProgressIndicator(
                minHeight: 30,
                backgroundColor: Colors.white,
                value: ((spravneOdpovedi % 100) / 100),
              )),
        ),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$a $znamenkoZnak $b = ',
                style: const TextStyle(
                  fontSize: 50,
                )),
            SizedBox(
              width: 200,
              height: 80,
              child: TextField(
                controller: resController,
                style: const TextStyle(fontSize: 50),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1-1000',
                    hintStyle: TextStyle(fontSize: 50)),
              ),
            )
          ],
        )),
        floatingActionButton: SizedBox(
            height: 100,
            width: 100,
            child: FloatingActionButton(
              backgroundColor: Colors.yellow[900],
              onPressed: () {
                refresh();
                var zprava = "";
                switch (spravneOdpovedi) {
                  case 100:
                    {
                      zprava = "Blížíte se ke správnému výpočtu.";
                      break;
                    }
                  case 200:
                    {
                      zprava =
                          "Zdá se, že chaotická éra a stabilní éra se pravidelně střídají.";
                      break;
                    }
                  case 300:
                    {
                      zprava =
                          "V některých okamžicích se objeví až tři slunce na obloze zároveň.";
                      break;
                    }
                  case 400:
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
                if (spravneOdpovedi % 100 == 0 && spravneOdpovedi != 0) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Pokrok"),
                            content: (Text(zprava)),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"))
                            ],
                          ));
                }
                zprava = "";
              },
              tooltip: 'Ověřit výsledek',
              child: const Icon(
                Icons.check,
                size: 100,
              ),
            )));
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
  if (spravneOdpovedi < 400) {
    switch (znamenkoInt) {
      case 0:
        {
          znamenkoZnak = "+";
          a = Random().nextInt(99) + 1;
          b = Random().nextInt(100) + 1;
        }
        break;

      case 1:
        {
          znamenkoZnak = "-";
          a = Random().nextInt(99) + 1;
          b = Random().nextInt(a - 1) + 1;
        }
        break;

      case 2:
        {
          znamenkoZnak = "*";
          a = Random().nextInt(99) + 1;
          b = Random().nextInt(10) + 1;
        }
        break;

      case 3:
        {
          znamenkoZnak = "/";
          while (nDelitelu == 0) {
            a = Random().nextInt(99) + 1;
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
