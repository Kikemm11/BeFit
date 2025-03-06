/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';

import 'package:be_fit/models/TrainingPlan.dart';

class TrainingPlanServer with ChangeNotifier {
  List<TrainingPlan> _trainingPlans = [];
  TrainingPlan? _currentTrainingPlan;


  // Getters
  List<TrainingPlan> get trainingPlans => _trainingPlans;
  TrainingPlan? get currentTrainingPlan => _currentTrainingPlan;


  // Get all the training plans
  Future<String> getAllTrainingPlans() async {
    try {
      _trainingPlans = await DBProvider.db.readAllTrainingPlans();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  // Get one training plan given its id
  Future<TrainingPlan?> getOneTrainingPlan(int trainingPlanId) async {
    try {
      _currentTrainingPlan = await DBProvider.db.readOneTrainingPlan(trainingPlanId);
      notifyListeners();
      return _currentTrainingPlan;
    } catch (e) {
      return null;
    }
  }

  // Insert a training plan and manage UNIQUE constraint
  Future<String> insertTrainingPlan(TrainingPlan trainingPlan) async {
    try {
      await DBProvider.db.insertTrainingPlan(trainingPlan);
    } catch(e){
      if (e.toString().contains('UNIQUE')) {
        return 'UNIQUE';
      } else {
        return e.toString();
      }
    }
    return await getAllTrainingPlans();
  }

  // Update a training plan given its id
  Future<String> updateTrainingPlan(TrainingPlan trainingPlan) async {
    try {
      await DBProvider.db.updateTrainingPlan(trainingPlan);
    } catch(e){
      if (e.toString().contains('UNIQUE')) {
        return 'UNIQUE';
      } else {
        return e.toString();
      }
    }
    return await getAllTrainingPlans();
  }

  // Delete a training plan given its id
  Future<String> deleteTrainingPlan(TrainingPlan trainingPlan) async {
    try {
      await DBProvider.db.deleteTrainingPlan(trainingPlan);
    } catch(e){
      return e.toString();
    }
    return await getAllTrainingPlans();
  }
}