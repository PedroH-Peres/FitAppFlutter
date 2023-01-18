import 'package:fitapp/core/services/exercise_service.dart';
import 'package:fitapp/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _titleController = TextEditingController();

  final _repetitionController = TextEditingController();

  TimeOfDay timePicked = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar exercício")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.purpleAccent,
                border: Border.all(width: 1)),
            child: Text(
              "Exercício:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            padding: EdgeInsets.all(8),
          ),
          Form(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _repetitionController,
                          decoration: InputDecoration(
                            labelText: 'Repetições',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                            },
                            child:
                                Text("Horario: ${timePicked.format(context)}"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Provider.of<ExerciseService>(context, listen: false).addExercise(
                  Exercise(
                    titulo: _titleController.text,
                    quantidade: int.tryParse(_repetitionController.text),
                    tempo: timePicked,
                  ),
                );
                Navigator.of(context).pop();
                setState(() {
                  
                });
              },
              child: const Text("Confirmar"))
        ],
      ),
    );
  }
}