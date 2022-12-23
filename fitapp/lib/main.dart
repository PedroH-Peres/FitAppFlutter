import 'package:flutter/material.dart';

void main() {
  runApp(FitApp());
}

class FitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Text("Hello World!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan), ),
        ),
      ),
    );
  }
}