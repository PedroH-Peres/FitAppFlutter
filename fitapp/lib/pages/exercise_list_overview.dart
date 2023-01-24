import 'package:fitapp/components/appdrawer.dart';
import 'package:fitapp/core/services/exercise_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ExerciseOverview extends StatefulWidget {
  const ExerciseOverview({super.key});

  @override
  State<ExerciseOverview> createState() => _ExerciseOverviewState();
}

class _ExerciseOverviewState extends State<ExerciseOverview> {
  @override
  Widget build(BuildContext context) {
    final exercServ = Provider.of<ExerciseService>(context, listen: false);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Overview"),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Lista de exercícios:",
                style: TextStyle(fontSize: 20),
              ),
              margin: EdgeInsets.all(20),
            ),
            Divider(),
            Expanded(
              child: SizedBox(
                
                child: exercServ.getLength() == 0
                ? Center(child: Text("Nenhum exercício foi registrado!"))
                : ListView.builder(
                    itemCount: exercServ.getLength(),
                    itemBuilder: ((context, index) => Card(
                          child: ListTile(
                            title: Text(exercServ.itemByIndex(index).titulo),
                            leading: Text(exercServ
                                .itemByIndex(index)
                                .tempo!
                                .format(context)),
                            subtitle: Text(
                                "Repetições: ${exercServ.itemByIndex(index).quantidade} | Dia: ${exercServ.itemByIndex(index).weekDay.substring(0,3).toUpperCase()}"),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text("Confirmar"),
                                        content: Text(
                                            "Deseja remover este exercício?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Cancelar")),
                                          TextButton(
                                              onPressed: () {
                                                exercServ
                                                    .removeItem(index)
                                                    .then((value) {
                                                      setState(() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    }
                                                        );
                                              },
                                              child: Text("Confirmar"))
                                        ],
                                      )),
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ))),
              ),
            )
          ],
        ));
  }
}
