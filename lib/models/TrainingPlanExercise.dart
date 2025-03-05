/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

TrainingPlanExercise trainingPlanExerciseromJson(String str) => TrainingPlanExercise.fromJson(json.decode(str));
String trainingPlanExerciseToJson(TrainingPlanExercise data) => json.encode(data.toJson());

class TrainingPlanExercise {
  int? id;
  int trainingPlanInfoId;
  int exerciseId;
  DateTime createdAt;

  Exercise({
    this.id,
    required this.trainingPlanInfoId,
    required this.exerciseId,
    required this.createdAt
  });


  // Convertion methods

  factory TrainingPlanExercise.fromJson(Map<String, dynamic> json ) => TrainingPlanExercise(
      id: json["id"],
      trainingPlanInfoId: json["training_plan_info_id"] as int,
      exerciseId: json["exercise_id"] as int, 
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "training_plan_info_id": trainingPlanInfoId,
    "exercise_id": exerciseId,
    "created_at": createdAt.toIso8601String()
  };

}