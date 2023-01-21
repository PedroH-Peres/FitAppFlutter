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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Homepage"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            child: DateBar(),
            padding: EdgeInsets.all(5),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          Consumer(
            child: Expanded(
              child: Center(child: Text('Nenhum exercício registrado!')),
            ),
            builder: ((context, value, child) => exerciseServ.getLength() == 0
                ? child!
                : Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: exerciseServ.getLength(),
                        itemBuilder: ((context, index) => Card(
                              child: ListTile(
                                subtitle: Text(exerciseServ
                                    .itemByIndex(index)
                                    .quantidade
                                    .toString()),
                                leading: Text(exerciseServ
                                    .itemByIndex(index)
                                    .tempo!
                                    .format(context)),
                                title: Text(
                                    exerciseServ.itemByIndex(index).titulo),
                                trailing: PopupMenuButton(
                                  icon: const Icon(Icons.more_vert),
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(children: [
                                        Icon(
                                          Icons.edit,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Editar')
                                      ]),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(children: [
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
                                    } else if (value == 2) {
                                      showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              title: Text("Confirmar"),
                                              content: Text(
                                                  "Deseja remover este exercício?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancelar")),
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        exerciseServ
                                                            .removeItem(index);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Confirmar"))
                                              ],
                                            )),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )),
                      ),
                    ),
                  )),
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
    );
  }
}
