import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/roupas.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Inicializa o FFI (obrigatório no desktop)
    sqfliteFfiInit();

    // Define fábrica como FFI
    var dbFactory = databaseFactoryFfi;

    final dbPath = await dbFactory.getDatabasesPath();
    final path = join(dbPath, 'roupas.db');

    print("📌 Banco de dados em: $path");

    return await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE roupas(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              tipo TEXT,
              descricao TEXT,
              tamanho TEXT,
              condicao TEXT
            )
          ''');
        },
      ),
    );
  }

  Future<int> insertRoupa(Roupa roupa) async {
    final db = await database;
    return await db.insert(
      'roupas',
      roupa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Roupa>> getRoupas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('roupas');

    return List.generate(
      maps.length,
          (i) => Roupa.fromMap(maps[i]),
    );
  }

  Future<int> deleteRoupa(int id) async {
    final db = await database;
    return await db.delete(
      'roupas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
