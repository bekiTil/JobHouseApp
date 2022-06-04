import 'dart:io';
import 'package:frontend/data_Providers/local/mock_model/book_mark.dart';
import 'package:frontend/data_Providers/local/mock_model/com_profile.dart';
import 'package:frontend/data_Providers/local/mock_model/emp_profile.dart';
import 'package:frontend/data_Providers/local/mock_model/post_.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:frontend/models/user.dart';
// import 'package:frontend/screens/bookmark/bookmark_update.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:frontend/models/Company.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  static const userTable = "user";
  static const empProfile = "EmployeeProfile";
  static const comProfile = "CompanyProfile";
  static const bookTable = "Bookmark";
  static const postTable = "Post";

  DBProvider._();
  Future<Database?> get database async {
    if (kIsWeb){

      print("web is it");
      return null;
    }
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'jobhouse.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE $bookTable (
id TEXT PRIMARY KEY,
post_id TEXT,
user_id TEXT,
memo TEXT
)''');
        await db.execute('''
CREATE TABLE $postTable (
id TEXT PRIMARY KEY,
number INTEGER,
description TEXT,
category TEXT
)''');
        await db.execute('''
  CREATE TABLE $empProfile (
    id TEXT PRIMARY KEY,
  username TEXT,
  email TEXT,
  password TEXT,
  role TEXT,
  fullName TEXT,
    fieldOfStudy TEXT,
    educationLevel TEXT,
    yearsOfExperience INTEGER,
    location TEXT,
    bio TEXT
  )
''');
        await db.execute('''
  CREATE TABLE $comProfile (
    id TEXT PRIMARY KEY,
  username TEXT,
  email TEXT,
  password TEXT,
  role TEXT,
  fullName TEXT,
    location TEXT,
    bio TEXT
  )
''');
      },
    );
  }

  //creating new Employee Profile
  createEmployeeProfile(MockEmpProfile employeeProfile) async {
    await deleteAll();
    
    final db = await database;
    print(db);
    if (db==null){
      print("becaues it is null we can't use web");
    }
    final response = await db!.insert(empProfile, employeeProfile.toJson());
    return response;
  }

  updateEmployeeProfile(MockEmpProfile employeeProfile) async {
    await deleteAll();
    final db = await database;
    final response = await db!.update(empProfile, employeeProfile.toJson(),
        where: "id= '${employeeProfile.id}'");
    return response;
  }

  deleteEmployee() async {
    final db = await database;
    final response1 = await db!.rawDelete('DELETE FROM $empProfile');
  }

  //creating new Company Profile
  createCompanyProfile(MockCompProfile companyProfile) async {
    final db = await database;
    final response = await db!.insert(
      comProfile,
      companyProfile.toJson(),
    );
    return response;
  }

  updateCompanyProfile(MockCompProfile compProfile) async {
    final db = await database;
    final response = await db!.update(empProfile, compProfile.toJson(),
        where: "id= '${compProfile.id}'");
    return response;
  }

  deleteCompany() async {
    final db = await database;
    final response1 = await db!.rawDelete('DELETE FROM $comProfile');
  }

  deleteAll() async {
    final db = await database;
    final response1 = await db!.rawDelete('DELETE FROM $empProfile');
    final responsee2 = await db.rawDelete('DELETE FROM $comProfile');
    return response1;
  }

  Future<MockEmpProfile?> findEmployeeById(String id) async {
    final db = await database;
    final userJson = await db!.query(empProfile, where: "id='"+ id + "'");
    print('skjdksjdksjdksj');
    print(userJson);
    if (userJson.isNotEmpty) {
      return MockEmpProfile.fromJson(userJson.first);
    } else {
      return null;
    }
  }

  Future<MockCompProfile?> findCompanyById(String id) async {
    final db = await database;
     print(db);
    if (db==null){
      print('helo');
    }
    final companyJson = await db!.query(empProfile, where: "id='"+ id + "'");
    print(companyJson);
    if (companyJson.isNotEmpty) {
      return MockCompProfile.fromJson(companyJson.first);
    } else {
      return null;
    }
  }

  createBookmark(MockBookmark mockBookmark) async {
    final db = await database;
    final response = await db!.insert(
      bookTable,
      mockBookmark.toJson(),
    );
    return response;
  }

  createPost(MockPost mockPost) async {
    final db = await database;
    final response = await db!.insert(
      bookTable,
      mockPost.toJson(),
    );
    return response;
  }

  UpdateBookmark(MockBookmark mockBookmark) async {
    await deleteAll();
    final db = await database;
    final response = await db!.update(bookTable, mockBookmark.toJson(),
        where: "id= '${mockBookmark.id}'");
    return response;
  }

  UpdatePost(MockPost mockPost) async {
    await deleteAll();
    final db = await database;
    final response = await db!
        .update(bookTable, mockPost.toJson(), where: "id= '${mockPost.id}'");
    return response;
  }

  deleteBookmark(MockBookmark mockBookmark) async {
    final db = await database;
    final response =
        await db!.delete(bookTable, where: "id= '${mockBookmark.id}'");
  }

  deletePost(MockPost mockPost) async {
    final db = await database;
    final response = await db!.delete(bookTable, where: "id= '${mockPost.id}'");
  }

  Future<List<MockBookmark>> mockbookmarks() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> res = await db!.query(bookTable);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return res.map((c) => MockBookmark.fromJson(c)).toList();
  }

  Future<List<MockPost>?> mockPosts() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> res = await db!.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    if (res.isNotEmpty) {
      return res.map((c) => MockPost.fromJson(c)).toList();
    } else {
      return null;
    }
  }
}
