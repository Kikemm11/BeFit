/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';

import 'package:be_fit/models/TrainingPlan.dart';

class TrainingPlanServer with ChangeNotifier {
  List<TrainingPlan> _trainingPlans = [];
  TrainingPlan? _currentTrainingPlan;
  TrainingPlan? _upperBodyTrainingPlan;
  TrainingPlan? _bottomBodyTrainingPlan;
  TrainingPlan? _absTrainingPlan;



  // Getters
  List<TrainingPlan> get trainingPlans => _trainingPlans;
  TrainingPlan? get currentTrainingPlan => _currentTrainingPlan;
  TrainingPlan? get upperBodyTrainingPlan => _upperBodyTrainingPlan;
  TrainingPlan? get bottomBodyTrainingPlan => _bottomBodyTrainingPlan;
  TrainingPlan? get absTrainingPlan => _absTrainingPlan;


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

  // Check if the user already have an active training plan given a training plan info
  Future<bool> hasTrainingPlanActive(int trainingPlanInfoId) async {
    try {
      return await DBProvider.db.readOneTrainingPlanByInfoAndActive(trainingPlanInfoId);
    } catch (e) {
      return false;
    }
  }

  // Get upper body training plan
  Future<String> getUpperBodyTrainingPlanByInfo(int trainingPlanInfoId) async {
    try {
      _upperBodyTrainingPlan = await DBProvider.db.readOneTrainingPlanByInfo(trainingPlanInfoId);
      notifyListeners();
      return 'ok';
    } catch (e) {
      _upperBodyTrainingPlan = null;
      return 'null';
    }
  }

  // Get bottom body training plan
  Future<String> getBottomBodyTrainingPlanByInfo(int trainingPlanInfoId) async {
    try {
      _bottomBodyTrainingPlan = await DBProvider.db.readOneTrainingPlanByInfo(trainingPlanInfoId);
      notifyListeners();
      return 'ok';
    } catch (e) {
      _bottomBodyTrainingPlan = null;
      return 'null';
    }
  }

  // Get abs training plan
  Future<String> getAbsBodyTrainingPlanByInfo(int trainingPlanInfoId) async {
    try {
      _absTrainingPlan = await DBProvider.db.readOneTrainingPlanByInfo(trainingPlanInfoId);
      notifyListeners();
      return 'ok';
    } catch (e) {
      _absTrainingPlan = null;
      return 'null';
    }
  }

  // Insert a training plan
  Future<String> insertTrainingPlan(TrainingPlan trainingPlan) async {
    try {
      await DBProvider.db.insertTrainingPlan(trainingPlan);
    } catch(e){
      return e.toString();
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