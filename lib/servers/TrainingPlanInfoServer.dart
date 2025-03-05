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
  TrainingPlanInfo? get _currentTrainingPlanInfo => _currentTrainingPlanInfo;


  // Get all the products
  Future<String> getAllTrainingPlanInfos() async {
    try {
      _trainingPlanInfos = await DBProvider.db.readAllTrainingPlanInfos();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

// Get one product given its id
  Future<TrainingPlanInfo?> getOneTrainingPlanInfo(int TrainingPlanInfoId) async {
    try {
      _currentTrainingPlanInfo = await DBProvider.db.readOneTrainingPlanInfo(trainingPlanInfoId);
      notifyListeners();
      return _currentTrainingPlanInfo;
    } catch (e) {
      return null;
    }
  }

}