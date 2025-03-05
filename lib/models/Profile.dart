/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

 Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int? id;
  String name;
  String genre;
  int biotypeId;
  double height;
  double weight;
  double armMeasure;
  double legMeasure;
  DateTime createdAt;

  Profile({
    this.id,
    required this.name,
    required this.genre,
    required this.biotypeId,
    required this.height,
    required this.weight,
    required this.armMeasure,
    required this.legMeasure,
    required this.createdAt
  });


  // Convertion methods

  factory Profile.fromJson(Map<String, dynamic> json ) => Profile(
      id: json["id"],
      name: json["name"] as String,
      genre: json["genre"] as String,
      biotypeId: json["biotype_id"] as int,
      height: json["height"] as double,
      weight: json["weight"] as double,
      armMeasure: json["arm_measure"] as double,
      legMeasure: json["leg_measure"] as double,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "genre": genre,
    "biotype_id": biotypeId,
    "height": height,
    "weight": weight,
    "arm_measure": armMeasure,
    "leg_measure": legMeasure,
    "created_at": createdAt.toIso8601String()
  };

}