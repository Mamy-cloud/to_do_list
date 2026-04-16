import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE list (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        list TEXT NOT NULL
      )
    ''');

    // Insérer les tâches par défaut
    final tasks = [
      'Se lever',
      'Manger',
      'Se laver',
      'Aller au marché',
      'Regarder la télé',
    ];

    for (final task in tasks) {
      await db.insert('list', {'list': task});
    }
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    return await db.query('list', orderBy: 'id ASC');
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}