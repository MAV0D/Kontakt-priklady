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
  int _counter = 0;
  int a = 0;
  int b = 0;
  var znamenkoInt = 0;
  var znamenkoZnak = ' ';
  var delitele = [];
  var nDelitelu = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      znamenkoInt = Random().nextInt(3);
      a = Random().nextInt(99) + 1;
      switch (znamenkoInt) {
        case 0:
          {
            znamenkoZnak = "+";
            b = Random().nextInt(100) + 1;
          }
          break;

        case 1:
          {
            znamenkoZnak = "-";
            b = Random().nextInt(a - 1) + 1;
          }
          break;

        case 2:
          {
            znamenkoZnak = "*";
            b = Random().nextInt(10) + 1;
          }
          break;

        case 3:
          {
            znamenkoZnak = "/";
            for (var i = 2; i < sqrt(a); i++) {
              if (a % i == 0) {
                delitele[nDelitelu] = i;
                nDelitelu++;
              }
            }
            if (nDelitelu != 0) {
              b = delitele[Random().nextInt(nDelitelu)];
            } else {
              b = a;
            }
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
            Text('$a'),
            Text(znamenkoZnak),
            Text('$b'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
