import 'dart:math';

import 'package:fitapp/components/appdrawer.dart';
import 'package:fitapp/components/datebar.dart';
import 'package:fitapp/core/services/db_util.dart';
import 'package:fitapp/core/services/exercise_service.dart';
import 'package:fitapp/main.dart';
import 'package:fitapp/models/appcontroller.dart';
import 'package:fitapp/pages/form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static String selectedDay =
      DateFormat(DateFormat.WEEKDAY).format(DateTime.now());

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

  List days = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    days = List.generate(7, (index) {
      DateTime date = DateTime(2022, 12, 25).add(Duration(days: index));
      return DateFormat(DateFormat.WEEKDAY).format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseServ = Provider.of<ExerciseService>(context, listen: false);
    verifyDay(int index) {
      return GestureDetector(
        child: Center(
          child: Text(
            "${days[index].substring(0, 3).toUpperCase()}",
            style: TextStyle(color: Colors.black),
          ),
        ),
        onTap: (() {
          setState(() {
            HomePage.selectedDay = days[index];
            exerciseServ.todayItems();
          });
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Homepage"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 7; i++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              HomePage.selectedDay = days[i];
                              exerciseServ.todayItems();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 2, right: 2, top: 14, bottom: 10),
                            height: 26,
                            decoration: BoxDecoration(
                              color: days[i] == HomePage.selectedDay
                                  ? Colors.purpleAccent.shade100
                                  : Colors.white,
                              border: Border.all(width: 1),
                              /*boxShadow: [BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.75)
                                )]*/
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                            child: verifyDay(i),
                          ),
                        ),
                      )
                  ],
                ),
                Divider(color: Colors.black,)
              ],
            ),
          ),

          FutureBuilder(
            future: Provider.of<ExerciseService>(context, listen: false)
                .loadPlaces(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer(
                        child: Expanded(
                          child: Center(
                              child: Text('Nenhum exercício registrado!')),
                        ),
                        builder: ((context, value, child) =>
                            exerciseServ.getTodayItems.length == 0
                                ? child!
                                : Expanded(
                                    child: SafeArea(
                                      child: SizedBox(
                                          child: ListView.builder(
                                        itemCount: exerciseServ.getLength(),
                                        itemBuilder: ((context, index) {
                                          bool _isEmpty = false;
                                          bool showCh = false;
                                          return exerciseServ
                                                      .itemByIndex(index)
                                                      .weekDay ==
                                                  HomePage.selectedDay
                                              ? Card(
                                                  child: ListTile(
                                                    subtitle: Text("Repetições: ${exerciseServ
                                                        .itemByIndex(index)
                                                        .quantidade
                                                        .toString()}"),
                                                    leading: Text(exerciseServ
                                                        .itemByIndex(index)
                                                        .tempo!
                                                        .format(context)),
                                                    title: Text(exerciseServ
                                                        .itemByIndex(index)
                                                        .titulo
                                                        .toString()),
                                                    trailing: PopupMenuButton(
                                                      icon: const Icon(
                                                          Icons.more_vert),
                                                      itemBuilder: (_) => [
                                                        PopupMenuItem(
                                                          value: 1,
                                                          child: Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.delete,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text('Remover')
                                                              ]),
                                                        ),
                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 1) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                ((context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Confirmar"),
                                                                      content: Text(
                                                                          "Deseja remover este exercício?"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed: () => Navigator.pop(
                                                                                context),
                                                                            child:
                                                                                Text("Cancelar")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                exerciseServ.removeItem(index).then((value) => Navigator.of(context).pop());
                                                                              });
                                                                            },
                                                                            child:
                                                                                Text("Confirmar"))
                                                                      ],
                                                                    )),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                )
                                              : SizedBox();
                                        }),
                                      )),
                                    ),
                                  )),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => FormPage()))
                      .then(((value) {
                    setState(() {});
                  }));
                },
                child: const Text("Adicionar exercício")),
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          print(DbUtil.getData('exercises'));
        },
      ),*/
    );
  }
}
