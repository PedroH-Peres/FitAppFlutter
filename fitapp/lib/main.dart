import 'package:fitapp/core/services/exercise_service.dart';
import 'package:fitapp/models/appcontroller.dart';
import 'package:fitapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


void main() {

  runApp(FitApp());
}

class FitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: ((context, child) {
        
        return ChangeNotifierProvider(
          create: ((context) => ExerciseService()),
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
          supportedLocales: [const Locale('pt', 'BR')],
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
              ),
        );

      }),
      
    );
  }
}


