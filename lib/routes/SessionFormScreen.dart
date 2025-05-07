import 'package:be_fit/widgets/BeFitCreateTrainingPlanAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';

import '../widgets/BeFitTrainingSessionCardWidget.dart';
import '../widgets/TrainingExercisesDialogWidget.dart';

class SessionFormScreen extends StatefulWidget {
  final TrainingSession session;
  final TrainingPlan trainingPlan;

  SessionFormScreen({
    required this.session,
    required this.trainingPlan
  });


  @override
  _SessionFormScreenState createState() => _SessionFormScreenState(session: session, trainingPlan: trainingPlan);
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  final TrainingSession session;
  final TrainingPlan trainingPlan;

  late Timer _timer;
  int _secondsElapsed = 0;

  bool createControllers = false;

  Map<int, TextEditingController> _controllers = {};

  _SessionFormScreenState({
    required this.session,
    required this.trainingPlan
  });

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fetchExercises();


  }

  Future<void> _fetchExercises() async {
    await context.read<ExerciseServer>().getAllExercisesByPlanInfo(trainingPlan.trainingPlanInfoId);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String get _formattedTime {
    final minutes = _secondsElapsed ~/ 60;
    final seconds = _secondsElapsed % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldLeave = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Estás seguro?'),
            content: Text('Perderás los cambios si sales de esta pantalla.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Salir'),
              ),
            ],
          ),
        );
        return shouldLeave ?? false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('BeFit'),
            backgroundColor: Colors.cyan[600],
          ),
          body: Consumer<ExerciseServer>(
            builder: (context, value, child){
      
              if (!createControllers)
              {
                for (var i = 0; i < value.exercises.length; i++) {
                  _controllers[i] = TextEditingController();
                }
                createControllers = true;
              }
      
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Sesión ${DateFormat('dd/MM/yyyy').format(session.createdAt)}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_formattedTime',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                      const SizedBox(height: 20,),
                      Column(
                        children: [
                          ...List.generate(value.exercises.length, (index) {
                            final exercise = value.exercises[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.fitness_center, color: Colors.cyan[200],),
                                      SizedBox(width: 10),
                                      Expanded(child: Text(exercise.name)),
                                      SizedBox(
                                        width: 60,
                                        child: TextField(
                                          controller: _controllers[index],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          decoration: InputDecoration(
                                            hintText: '0',
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextButton(
                            onPressed: (){
                              showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('¿Finalizar entrenamiento?'),
                                  content: Text('Se guardará todo tu progreso'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: Text('Cancelar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        String result = await context.read<TrainingSessionServer>().updateTrainingSession(session, _controllers, _secondsElapsed);

                                        if (result == 'Ok')
                                          {

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Sesión guardada existosamente!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        else
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Ups! Ha ocurrido un error guardando tu sesión'),
                                                  backgroundColor: Colors.red,
                                                ),
                                            );
                                            Navigator.pop(context);
                                          }

                                      },
                                      child: Text('Guardar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.cyan[100]),
                            ),
                            child: Text('Guardar')),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
