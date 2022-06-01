// import 'package:frontend/models/Company.dart';
// import 'package:frontend/repository/local/database.dart';
// import 'package:sqflite/sqflite.dart';

// class CompanyLocalStorage {
//   final dbProvider = DBProvider();

//   Future<void> createCompany(Company company) async {
//     final db = await dbProvider.initializeDB();
//     db.insert('company', company.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<void> updateCompany(Company company) async {
//     final db = await dbProvider.initializeDB();

//     await db.update(
//       'company',
//       company.toMap(),
//       where: 'id = ?',
//       whereArgs: [company.id],
//     );
//   }

//   Future<void> deleteCompany(String id) async {
//     final db = await dbProvider.initializeDB();
//     await db.delete(
//       'company',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<Company> getCompany(String id) async {
//     final db = await dbProvider.initializeDB();
//     List<Map<String, dynamic>> user = await db.query(
//       'company',
//       where: 'id = ?',
//       whereArgs: [id],
//       limit: 1,
//     );
//     return Company(
//       user[0]['id'],
//       user[0]['fullName'],
//       user[0]['username'],
//       user[0]['email'],
//       user[0]['role'],
//       user[0]['location'],
//       user[0]['bio'],
//       user[0]['token'],
//     );
//   }

//   Future<List<Company>> getCompanies() async {
//     final db = await dbProvider.initializeDB();
//     final List<Map<String, dynamic>> maps = await db.query('company');

//     return List.generate(maps.length, (i) {
//       return Company(
//           maps[i]['id'],
//           maps[i]['fullName'],
//           maps[i]['username'],
//           maps[i]['email'],
//           maps[i]['role'],
//           maps[i]['location'],
//           maps[i]['bio'],
//           maps[i]['token']);
//     });
//   }
// }
