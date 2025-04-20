import 'package:be_fit/servers/ExerciseServer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart' as carousel;

class BeFitTrainingExercisesDialog extends StatefulWidget {
  final int trainingPlanInfoId;

  const BeFitTrainingExercisesDialog({
    Key? key,
    required this.trainingPlanInfoId,
  }) : super(key: key);

  @override
  State<BeFitTrainingExercisesDialog> createState() =>
      _BeFitTrainingExercisesDialogState();
}

class _BeFitTrainingExercisesDialogState
    extends State<BeFitTrainingExercisesDialog> {

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  // Get exercises
  Future<void> _fetchExercises() async {
    await context.read<ExerciseServer>().getAllExercisesByPlanInfo(widget.trainingPlanInfoId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseServer>(
        builder: (context, value, child){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 350,
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ejercicios',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  carousel.CarouselSlider(
                    options: carousel.CarouselOptions(
                      height: 450,

                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.9,
                    ),
                    items: value.exercises.map((exercise) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey[100],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: Image.asset(
                                      'lib/assets/exercises/${exercise.imgPath}',
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: Text(
                                        exercise.name,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      exercise.description,
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
