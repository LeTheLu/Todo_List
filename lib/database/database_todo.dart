import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/database/table_todo.dart';
import 'package:todo_list/models/model_todo.dart';

class TodoDatabase {
  static const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;
  static Database? _database;

  static final TodoDatabase instance = TodoDatabase._init();
  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(path, version: DB_VERSION,
        onCreate: (Database db, int version) async {
      await db.execute(TodoTable.CREATE_TABLE_QUERY);
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      TodoTable.TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;

    await db.delete(
      TodoTable.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;

    await db.update(
      TodoTable.TABLE_NAME,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> Todos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TodoTable.TABLE_NAME);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        content: maps[i]['content'],
        title: maps[i]['title'],
        dateTime: maps[i]['dateTime'],
        clock: maps[i]['clock'],
        important: maps[i]['important'],
        done: maps[i]['done']
      );
    });
  }
}
