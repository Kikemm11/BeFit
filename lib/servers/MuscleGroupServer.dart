/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/MuscleGroup.dart';

class MuscleGroupServer with ChangeNotifier {
  List<MuscleGroup> _muscleGroups = [];


  // Getters
  List<MuscleGroup> get muscleGroups => _muscleGroups;


  // Get all the products
  Future<String> getAllMuscleGroups() async {
    try {
      _muscleGroups = await DBProvider.db.readAllMuscleGroups();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

}