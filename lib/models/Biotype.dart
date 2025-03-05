/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'dart:convert';

Biotype biotypeFromJson(String str) => Biotype.fromJson(json.decode(str));
String biotypeToJson(Biotype data) => json.encode(data.toJson());

class Biotype {
  int? id;
  String name;
  String description;
  DateTime createdAt;

  Biotype({
    this.id,
    required this.name,
    required this.description,
    required this.createdAt
  });


  // Convertion methods

  factory Biotype.fromJson(Map<String, dynamic> json ) => Biotype(
      id: json["id"],
      name: json["name"] as String,
      description: json["description"] as String,
      createdAt: DateTime.parse(json["created_at"] as String)
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt.toIso8601String()
  };

}