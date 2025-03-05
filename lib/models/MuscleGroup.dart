/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

 MuscleGroup muscleGroupFromJson(String str) => MuscleGroup.fromJson(json.decode(str));
String muscleGroupToJson(MuscleGroup data) => json.encode(data.toJson());

class MuscleGroup {
  int? id;
  String name;
  DateTime createdAt;

  MuscleGroup({
    this.id,
    required this.name,
    required this.createdAt
  });


  // Convertion methods

  factory MuscleGroup.fromJson(Map<String, dynamic> json ) => MuscleGroup(
      id: json["id"],
      name: json["name"] as String,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String()
  };

}