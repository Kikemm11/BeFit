/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/Exercise.dart';


class ExerciseServer with ChangeNotifier {
  List<Exercise> _exercises = [];


  // Getters
  List<Exercise> get exercises => _exercises;


  // Query all the exercises from the database 
  Future<String> getAllExercises() async {
    try {
      _exercises = await DBProvider.db.readAllExercises();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  // Query all the exercises related to a plan info
  Future<String> getAllExercisesByPlanInfo(int planInfoId) async {
    try {
      _exercises = await DBProvider.db.readAllExercisesByPlanInfo(planInfoId);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

}