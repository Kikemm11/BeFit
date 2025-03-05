/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/TrainingPlanExercise.dart';

class ProfileServer with ChangeNotifier {
  List<TrainingPlanExercise> _trainingPlanExercises = [];


  // Getters
  List<TrainingPlanExercise> get trainingPlanExercises => _trainingPlanExercises;


  // Get all the products
  Future<String> getAllTrainingPlanExercises() async {
    try {
      _trainingPlanExercises = await DBProvider.db.readAllTrainingPlanExercises();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

}