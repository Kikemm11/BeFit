/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/TrainingPlanInfo.dart';

class TrainingPlanInfoServer with ChangeNotifier {
  List<TrainingPlanInfo> _trainingPlanInfos = [];
  TrainingPlanInfo? _currentTrainingPlanInfo;


  // Getters
  List<TrainingPlanInfo> get trainingPlanInfos => _trainingPlanInfos;
  TrainingPlanInfo? get currentTrainingPlanInfo => _currentTrainingPlanInfo;


  // Get all the training plan infos
  Future<String> getAllTrainingPlanInfos() async {
    try {
      _trainingPlanInfos = await DBProvider.db.readAllTrainingPlanInfos();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

// Get one training plan info given its id
  Future<TrainingPlanInfo?> getOneTrainingPlanInfo(int trainingPlanInfoId) async {
    try {
      _currentTrainingPlanInfo = await DBProvider.db.readOneTrainingPlanInfo(trainingPlanInfoId);
      notifyListeners();
      return _currentTrainingPlanInfo;
    } catch (e) {
      return null;
    }
  }

}