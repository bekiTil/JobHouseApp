import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  late Database db;

  Future<Database> open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'doggie_database.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            create table Company ( 
              id TEXT, 
              fullName TEXT not null,
              username TEXT not null),
              email TEXT,
              role TEXT,
              companyProfileId integer,
              FOREIGN KEY (companyProfile) REFERENCES CompanyProfile (id)
            ''');
      await db.execute('''
            create table CompanyProfile ( 
              id integer primary key autoincrement, 
              location TEXT,
              bio TEXT,
              ''');
    });
    return db;
  }
}
