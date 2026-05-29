import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserRepository {
  static Future<void> insertUsers() async {
    String jsonString = await rootBundle.loadString('assets/registered_users.json');
    List<dynamic> users = json.decode(jsonString);
    Database db = await DBHelper.initDB();

    for (var user in users) {
      await db.insert("users", user, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final jsonString = await rootBundle.loadString('assets/registered_users.json');
      final List<dynamic> data = json.decode(jsonString);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error loading users: $e');
      return [];
    }
  }
}
