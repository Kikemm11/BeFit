/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));
String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  int? id;
  String name;
  String imgPath;
  String description;
  DateTime createdAt;

  Exercise({
    this.id,
    required this.name,
    required this.imgPath,
    required this.description,
    required this.createdAt
  });


  // Convertion methods

  factory Exercise.fromJson(Map<String, dynamic> json ) => Exercise(
      id: json["id"],
      name: json["name"] as String,
      imgPath: json["img_path"],
      description: json["description"] as String,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img_path": imgPath,
    "description": description,
    "created_at": createdAt.toIso8601String()
  };

}