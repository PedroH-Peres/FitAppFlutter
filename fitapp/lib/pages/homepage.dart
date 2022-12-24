import 'package:fitapp/components/appdrawer.dart';
import 'package:fitapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Página inicial"),
            Divider(),
            Text("FIM"),
            TextButton(onPressed: (){
              themeNotifier.instance.changeTheme();
            }, child: Text("Mudar"))
          ],
        ),
      ),
      
    );
  }
}

class themeNotifier extends ChangeNotifier{
  static themeNotifier instance = themeNotifier();
  bool isDarkTheme = false;
  changeTheme(){
    isDarkTheme = !isDarkTheme;
    print("mudou");
    notifyListeners();
  }
}