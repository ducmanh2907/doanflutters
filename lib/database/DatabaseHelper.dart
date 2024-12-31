// lib/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
// Import the User model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Tên bảng người dùng
  final String tableUsers = 'users';
  final String columnId = 'id';
  final String columnName = 'username';
  final String columnEmail = 'email';
  final String columnPhoneNumber = 'phoneNumber';
  final String columnAddress = 'address';

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tạo bảng users nếu chưa tồn tại
    await db.execute('''
      CREATE TABLE $tableUsers (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPhoneNumber TEXT NOT NULL,
        $columnAddress TEXT NOT NULL
      )
    ''');
  }

  // Thêm một người dùng vào bảng users
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(tableUsers, user.toMap());
  }

  // Lấy người dùng theo email và mật khẩu (tùy chỉnh nếu bạn muốn)
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    // Bạn có thể thêm cột password vào bảng users nếu cần xác thực
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableUsers,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null; // Trả về null nếu không tìm thấy người dùng
    }
  }

  // Cập nhật thông tin người dùng (nếu cần)
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      tableUsers,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  // Xóa người dùng
  Future<int> deleteUser(String userId) async {
    final db = await database;
    return await db.delete(
      tableUsers,
      where: '$columnId = ?',
      whereArgs: [userId],
    );
  }

  // Lấy tất cả người dùng
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableUsers);

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }
}

