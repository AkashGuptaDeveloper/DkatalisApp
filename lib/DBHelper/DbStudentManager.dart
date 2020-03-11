import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStudentManager {
  Database _database;
//---------------------------Create-openDb-------------------------------------//
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "AKASHGUPTA.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement, name TEXT, course TEXT)",
        );
      });
    }
  }
//---------------------------Create-insertStudent-----------------------------//
  Future<int> insertStudent(Employee student) async {
    await openDb();
    return await _database.insert('student', student.toMap());
  }
//---------------------------Fetch-List-getStudentList-------------------------//
  Future<List<Employee>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Employee(
          id: maps[i]['id'], name: maps[i]['name'], course: maps[i]['course']);
    });
  }
}
//------------------------------------Create-Model-Student---------------------//
class Employee {
  int id;
  String name;
  String course;
  Employee({@required this.name, @required this.course, this.id});
  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course};
  }
}
//------------------------------------END-------------------------------------//
