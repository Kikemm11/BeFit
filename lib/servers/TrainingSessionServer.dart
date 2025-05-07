/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/TrainingSession.dart';

class TrainingSessionServer with ChangeNotifier {
  List<TrainingSession> _trainingSessions = [];
  TrainingSession? _currentTrainingSession;


  // Getters
  List<TrainingSession> get trainingSessions => _trainingSessions;
  TrainingSession? get currentTrainingSession => _currentTrainingSession;


  // Get all the training sessions
  Future<String> getAllTrainingSessions() async {
    try {
      _trainingSessions = await DBProvider.db.readAllTrainingSessions();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  // Get one training session given its id
  Future<TrainingSession?> getOneTrainingSession(int trainingSessionId) async {
    try {
      _currentTrainingSession = await DBProvider.db.readOneTrainingSession(trainingSessionId);
      notifyListeners();
      return _currentTrainingSession;
    } catch (e) {
      return null;
    }
  }

  // Get all the training sessions of a plan
  Future<String> getTrainingSessionsPlan(int trainingPlanId) async {
    try {
      _trainingSessions = await DBProvider.db.readTrainingSessionsPlan(trainingPlanId);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

  // Insert a training session and manage UNIQUE constraint
  Future<String> insertTrainingSession(TrainingSession trainingSession) async {
    try {
      await DBProvider.db.insertTrainingSession(trainingSession);
    } catch(e){
      if (e.toString().contains('UNIQUE')) {
        return 'UNIQUE';
      } else {
        return e.toString();
      }
    }
    return await getAllTrainingSessions();
  }

  // Update a training session given its id
  Future<String> updateTrainingSession(TrainingSession trainingSession, Map<int, TextEditingController> exerciseReps, int trainingDuration) async {

    int avgReps;
    int sum = 0;
    for (final key in exerciseReps.keys)
      {
        sum += (( exerciseReps[key]!.text != '') ? int.tryParse(exerciseReps[key]!.text) : 0)!;
      }
    avgReps = (sum / exerciseReps.length).toInt();
    trainingSession.repsAvg = avgReps;
    trainingSession.done = true;
    trainingSession.duration = trainingDuration % 60;

    try {
      await DBProvider.db.updateTrainingSession(trainingSession);
    } catch(e){
      if (e.toString().contains('UNIQUE')) {
        return 'UNIQUE';
      } else {
        return e.toString();
      }
    }
    return await getAllTrainingSessions();
  }

  // Delete a training session given its id
  Future<String> deleteTrainingSession(TrainingSession trainingSession) async {
    try {
      await DBProvider.db.deleteTrainingSession(trainingSession);
    } catch(e){
      return e.toString();
    }
    return await getAllTrainingSessions();
  }
}