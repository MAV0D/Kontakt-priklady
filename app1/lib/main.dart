import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: const [
          Center(
            child: Text('Vypočítejte příklady:'),
          ),
          Center(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
