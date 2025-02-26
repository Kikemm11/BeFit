/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


// Class definition
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  // Singleton Database instance
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  // Enable SQLITE foreign keys
  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  // Insert initial data

  _insertInitialData(Database db) async {
    String createdAt = DateTime.now().toIso8601String();

    // Insert Exercises
    await db.insert('exercise', {"id": 1, "name": "Flexiones", "img_path": "flexiones.png", "description": "Cualquier descripci'on que quieran", "created_at": createdAt});

    // Insert Biotypes
    await db.insert('biotype', {"id": 1, "name": "Hectomorfo", "created_at": createdAt});


    // Insert Muscle Groups
    await db.insert('muscle_group', {"id": 1, "name": "Tren Superior", "created_at": createdAt});

    // Insert Training Plans Info
    await db.insert('training_plan_info', {"id": 1, "name": "Plan de Tren Superior (Hectomorfo/Masculino)", "biotype_id": 1, "genre": "M", "muscle_group_id": 1, "reps": 10, "series": 4, "rest": 5, "created_at": createdAt});

    // Insert Training Exercises
    await db.insert('training_plan_exercise', {"id": 1, "training_plan_info_id": 1, "exercise_id": 1, "created_at": createdAt});


  }

  // DB initializer
  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'enlanados_app_mobile.db'), onConfigure: _onConfigure,
        onCreate: (db, version) async {

          await db.execute('''
          CREATE TABLE exercise (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          img_path TEXT NOT NULL,
          DESCRIPTION TEXT
          created_at TEXT 
          );
          ''');

          await db.execute('''
          CREATE TABLE biotype (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          created_at TEXT,
        );
        ''');

          await db.execute('''
          CREATE TABLE muscle_group (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          created_at TEXT 
          );
          ''');

          await db.execute('''
          CREATE TABLE profile (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          genre TEXT NOT NULL,
          biotype_id INTEGER NOT NULL,
          height REAL NOT NULL,
          weight REAL NOT NULL,
          arm_measure REAL NOT NULL,
          leg_measure REAL NOT NULL,
          created_at TEXT,
          FOREIGN KEY (biotype_id) REFERENCES biotype(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan_info (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE NOT NULL,
          biotype_id INTEGER NOT NULL,
          genre TEXT NOT NULL,
          muscle_group_id INTEGER NOT NULL,
          reps INTEGER NOT NULL,
          series INTEGER NOT NULL,
          rest REAL NOT NULL,
          created_at TEXT,
          FOREIGN KEY (biotype_id) REFERENCES biotype(id),
          FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan_exercise (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_info_id INTEGER NOT NULL,
          exercise_id INTEGER NOT NULL,
          created_at TEXT,
          FOREIGN KEY (training_plan_info_id) REFERENCES training_plan_info(id),
          FOREIGN KEY (exercise_id) REFERENCES exercise(id) 
          );
          ''');

          await db.execute('''
          CREATE TABLE training_plan (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_info_id INTEGER NOT NULL,
          micro_goal INTEGER NOT NULL,
          meso_goal INTEGER NOT NULL,
          macro_goal INTEGER NOT NULL,
          due_date TEXT NOT NULL,
          active INTEGER,
          created_at TEXT,
          FOREIGN KEY (training_plan_info_id) REFERENCES training_plan_info(id)
          );
          ''');

          await db.execute('''
          CREATE TABLE training_session (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          training_plan_id INTEGER NOT NULL,
          duration REAL NOT NULL,
          reps_avg INTEGER NOT NULL,
          done INTEGER NOT NULL,
          created_at TEXT,
          FOREIGN KEY (training_plan_id) REFERENCES training_plan(id)
          );
          ''');

          await _insertInitialData(db);

        },
        version: 1
    );
  }

}