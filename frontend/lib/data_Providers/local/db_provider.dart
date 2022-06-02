import 'package:frontend/models/company_profile.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:frontend/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static  Database? _database;
  static final DBProvider db = DBProvider._();

  
  static const empProfile = "EmployeeProfile";
  static const comProfile = "CompanyProfile";

  DBProvider._();
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    // doesn't work for web but it does work for mac/android/ios
    final documentDirectory = await getDatabasesPath();
    final path = join(documentDirectory, 'jobhouse.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE $empProfile (
  id TEXT PRIMARY KEY,
  username TEXT,
  email TEXT,
  password TEXT,
  role TEXT,
  fullName TEXT
  fieldOfStudy TEXT,
  educationLevel TEXT,
  yearOfExperience INTEGER,
  location TEXT,
  bio TEXT
)''');

await db.execute('''
  CREATE TABLE $comProfile (
  id TEXT PRIMARY KEY,
  username TEXT,
  email TEXT,
  password TEXT,
  role TEXT,
  fullName TEXT
  location TEXT,
  bio TEXT
  )
''');
      },
    );
  }


  //creating new Employee Profile
  createEmployeeProfile(EmployeeProfile employeeProfile) async {
    final db= await database;
    final response= await db!.insert(empProfile,employeeProfile.toJson());
    return response;
  }
  
  //creating new Company Profile
  createCompanyProfile(CompanyProfile companyProfile) async {
    final db= await database;
    final response= await db!.insert(comProfile,companyProfile.toJson());
    return response;
  }

  deleteAll() async {
    final db = await database;
    final response1 = await db!.rawDelete('DELETE FROM $empProfile');
    final responsee2 = await db.rawDelete('DELETE FROM $comProfile');
    return response1;
  }
  Future<Object> findEmployeeById(String id) async{
    final db =await database;
    final employeeJson=await db!.query(empProfile, where: 'id= $id');
    return employeeJson.isNotEmpty ? User.fromJson(employeeJson.first) : Null; 
  
  }
  Future<Object> findCompanyById(String id) async{
    final db =await database;
    final companyJson=await db!.query(empProfile, where: 'id= $id');
    return companyJson.isNotEmpty ? User.fromJson(companyJson.first) : Null; 
  
  }
}
