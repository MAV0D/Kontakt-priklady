import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
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
  int a = 0;
  int b = 0;
  var znamenkoInt = 3;
  var znamenkoZnak = ' ';
  var delitele = [];
  var nDelitelu = 0;
  final controllerVysledek = TextEditingController();

  void _generateProblem() {
    setState(() {
      a = 0;
      b = 0;
      delitele = [];
      nDelitelu = 0;
      znamenkoInt = Random().nextInt(4);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$a $znamenkoZnak $b = '),
            TextField(controller: controllerVysledek)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateProblem,
        tooltip: 'Nový příklad',
        child: const Icon(Icons.add),
      ),
    );
  }
}
