import 'package:fitapp/components/appdrawer.dart';
import 'package:fitapp/components/datebar.dart';
import 'package:fitapp/main.dart';
import 'package:fitapp/models/appcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get teste {
    return Container(height: 30, color: Colors.blue,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: const AppDrawer(),
      body: DateBar()
      
    );
  }
}
