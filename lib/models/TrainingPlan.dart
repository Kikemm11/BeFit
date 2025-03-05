/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

TrainingPlan trainingPlanFromJson(String str) => TrainingPlan.fromJson(json.decode(str));
String trainingPlanToJson(TrainingPlan data) => json.encode(data.toJson());

class TrainingPlan {
  int? id;
  int microGoal;
  int mesoGoal;
  int macroGoal;
  DateTime dueDate;
  bool active;
  DateTime createdAt;

  TrainingPlan({
    this.id,
    required this.microGoal,
    required this.mesoGoal,
    required this.macroGoal,
    required this.dueDate,
    required this.active,
    required this.createdAt
  });


  // Convertion methods

  factory TrainingPlan.fromJson(Map<String, dynamic> json ) => TrainingPlan(
      id: json["id"],
      microGoal: json["micro_goal"] as int,
      mesoGoal: json["meso_goal"], as int,
      macroGoal: json["macro_goal"] as int,
      dueDate: json["due_date"] as String,
      active: (json["active"] as int) == 1 ? true : false,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "micro_goal": microGoal,
    "meso_goal": mesoGoal,
    "macro_goal": macroGoal,
    "due_date": dueDate.toIso8601String(),
    "active": (active) ? 1 : 0,
    "created_at": createdAt.toIso8601String()
  };

}