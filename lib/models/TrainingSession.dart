/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

TrainingSession trainingSessionromJson(String str) => TrainingSession.fromJson(json.decode(str));
String trainingSessionToJson(TrainingSession data) => json.encode(data.toJson());

class TrainingSession {
  int? id;
  int trainingPlanId;
  double? duration;
  int? repsAvg;
  bool? done;
  DateTime createdAt;

  TrainingSession({
    this.id,
    required this.trainingPlanId,
    this.duration = 0,
    this.repsAvg = 0,
    this.done = false,
    required this.createdAt
  });


  // Convertion methods

  factory TrainingSession.fromJson(Map<String, dynamic> json ) => TrainingSession(
      id: json["id"],
      trainingPlanId: json["training_plan_id"] as int,
      duration: json["duration"] as double, 
      repsAvg: json["reps_avg"] as int,
      done: (json["done"] as int) == 1 ? true : false,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "training_plan_id": trainingPlanId,
    "duration": duration,
    "reps_avg": repsAvg,
    "done": (done!) ? 1 : 0,
    "created_at": createdAt.toIso8601String()
  };

}