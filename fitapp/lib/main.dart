import 'package:fitapp/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FitApp());
}

class FitApp extends StatefulWidget {

  @override
  State<FitApp> createState() => _FitAppState();
}

class _FitAppState extends State<FitApp> {
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purpleAccent,
          brightness: themeNotifier.instance.isDarkTheme ? Brightness.dark : Brightness.light,
          secondary: Colors.blue
        ) ,
      ),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


