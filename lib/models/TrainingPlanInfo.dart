/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

TrainingPlanInfo trainingPlanInforomJson(String str) => TrainingPlanInfo.fromJson(json.decode(str));
String trainingPlanInfoToJson(TrainingPlanInfo data) => json.encode(data.toJson());

class TrainingPlanInfo {
  int? id;
  String name;
  int biotypeId;
  String genre;
  int muscleGroupId;
  int reps;
  int series;
  double rest;
  DateTime createdAt;

  TrainingPlanInfo({
    this.id,
    required this.name,
    required this.biotypeId,
    required this.genre,
    required this.muscleGroupId,
    required this.reps,
    required this.series,
    required this.rest,
    required this.createdAt
  });


  // Convertion methods

  factory TrainingPlanInfo.fromJson(Map<String, dynamic> json ) => TrainingPlanInfo(
      id: json["id"],
      name: json["name"] as String,
      biotypeId: json["biotype_id"] as int, 
      genre: json["genre"] as String,
      muscleGroupId: json["muscle_group_id"] as int,
      reps: json["reps"] as int,
      series: json["series"] as int,
      rest: json["rest"] as double,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "biotype_id": biotypeId,
    "genre": genre,
    "Muscle_group_id": muscleGroupId,
    "reps": reps,
    "series": series,
    "rest": rest,
    "created_at": createdAt.toIso8601String()
  };

}