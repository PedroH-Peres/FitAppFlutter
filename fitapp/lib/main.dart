import 'package:fitapp/models/appcontroller.dart';
import 'package:fitapp/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FitApp());
}

class FitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: ((context, child) {
        
        return MaterialApp(
        title: 'FitApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purpleAccent,
            brightness: AppController.instance.isDarkTheme ? Brightness.dark : Brightness.light,
            secondary: Colors.blue
          ) ,
        ),
        darkTheme: ThemeData.dark(),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );

      }),
      
    );
  }
}


