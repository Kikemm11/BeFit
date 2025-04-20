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
              height: 400,
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
                          onPressed: _selectedPlan == -1
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
                                String result = await context.read<TrainingPlanServer>().insertTrainingPlan(trainingPlan);

                                if (result == 'Ok')
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('plan creado con éxito!'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                else
                                {
                                  print(result);
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
