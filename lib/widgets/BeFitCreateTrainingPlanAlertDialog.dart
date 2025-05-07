import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';
import 'package:be_fit/widgets/TrainingExercisesDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/TrainingPlanInfo.dart';

class BeFitCreateTrainingPlanAlertDialog extends StatefulWidget {
  final TrainingPlanInfo upperBodyPlan;
  final TrainingPlanInfo bottomBodyPlan;
  final TrainingPlanInfo absPlan;

  const BeFitCreateTrainingPlanAlertDialog({
    Key? key,
    required this.upperBodyPlan,
    required this.bottomBodyPlan,
    required this.absPlan,
  }) : super(key: key);

  @override
  State<BeFitCreateTrainingPlanAlertDialog> createState() =>
      _BeFitCreateTrainingPlanAlertDialogState();
}

class _BeFitCreateTrainingPlanAlertDialogState
    extends State<BeFitCreateTrainingPlanAlertDialog> {
  int _selectedPlan = -1;

  List<String> weekdays = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  List<int> selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingPlanServer>(
        builder: (context, value, child){

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              height: 550,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Crea un plan de ejercicios',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      _buildPlanOption(widget.upperBodyPlan),
                      const SizedBox(height: 20),
                      _buildPlanOption(widget.bottomBodyPlan),
                      const SizedBox(height: 20),
                      _buildPlanOption(widget.absPlan),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selecciona 3 días de entrenamiento:'
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 6,
                    children: List.generate(weekdays.length, (index) {
                      return ChoiceChip(
                        label: Text(
                          weekdays[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                        selected: selectedDays.contains(index),
                        onSelected: (selected) {
                          setState(() {
                            if (selected && selectedDays.length < 3) {
                              selectedDays.add(index);
                            } else {
                              selectedDays.remove(index);
                            }
                          });
                        },
                        selectedColor: Colors.cyan[600],
                        backgroundColor: Colors.cyan[100],
                        labelPadding: EdgeInsets.zero,
                        padding: const EdgeInsets.all(8),
                        shape: const CircleBorder(),
                        visualDensity: VisualDensity.compact, // tight spacing
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: _selectedPlan == -1 || selectedDays.length != 3
                              ? null
                              : () async {

                            bool hasActivePlan = await context.read<TrainingPlanServer>().hasTrainingPlanActive(_selectedPlan);

                            if (hasActivePlan)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ups! Parece que ya tienes un plan activo'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            else
                              {
                                TrainingPlan trainingPlan = TrainingPlan(trainingPlanInfoId: _selectedPlan);
                                String result = await context.read<TrainingPlanServer>().insertTrainingPlan(trainingPlan, selectedDays);

                                if (result == 'Ok')
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Plan creado con éxito!'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Ups! Error al crear plan'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              }

                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Crear'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );




  }


  Widget _buildPlanOption(TrainingPlanInfo plan) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPlan = plan.id!;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (_selectedPlan == plan.id)
              ? Colors.cyan[600]
              : const Color(0xFFa2e4ec),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(plan.name),
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BeFitTrainingExercisesDialog(trainingPlanInfoId: plan.id!);
                  },
                );
              },
              icon: const Icon(Icons.info, color: Colors.yellow, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
