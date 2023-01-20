import 'package:fitapp/components/appdrawer.dart';
import 'package:fitapp/components/datebar.dart';
import 'package:fitapp/core/services/exercise_service.dart';
import 'package:fitapp/main.dart';
import 'package:fitapp/models/appcontroller.dart';
import 'package:fitapp/pages/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get teste {
    return Container(
      height: 30,
      color: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exerciseServ = Provider.of<ExerciseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Container(child: DateBar(), color: Colors.grey.shade300, padding: EdgeInsets.all(4),),
          Consumer(
            child: SizedBox(child: Center(child: Text('Nenhum exercício registrado!')), width: double.infinity, height: 500,),
            builder: ((context, value, child) => exerciseServ.getLength() == 0
                ? child!
                : SizedBox(
                  height: 600,
                  child: ListView.builder(
                      itemCount: exerciseServ.getLength(),
                      itemBuilder: ((context, index) => Card(
                        child: ListTile(
                              subtitle: Text(exerciseServ.itemByIndex(index).quantidade.toString()),
                              leading: Text(exerciseServ.itemByIndex(index).tempo!.format(context)),
                              title: Text(exerciseServ.itemByIndex(index).titulo),
                            ),
                      )),
                    ),
                )),
          ),
        ],
      ),

      /**/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => FormPage())).then(((value) {
                setState(() {
                  
                });
              }));
        },
      ),
    );
  }
}
