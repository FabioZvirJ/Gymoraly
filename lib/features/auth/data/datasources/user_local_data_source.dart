import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<int> registerUser(UserModel user);
  Future<UserModel?> loginUser(String email, String password);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'gymoraly.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            age INTEGER,
            gender TEXT,
            height REAL,
            weight REAL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS users');
          await db.execute('''
            CREATE TABLE users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              email TEXT,
              password TEXT,
              age INTEGER,
              gender TEXT,
              height REAL,
              weight REAL
            )
          ''');
        }
      },
    );
  }

  @override
  Future<int> registerUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  @override
  Future<UserModel?> loginUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }
}
