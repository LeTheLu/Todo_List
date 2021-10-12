class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY =
  '''CREATE TABLE $TABLE_NAME(
  id INTEGER PRIMARY KEY,
  content TEXT,
  title TEXT,
  dateTime TEXT,
  clock INTEGER,
  important INTEGER,
  done INTEGER
  )
  ''';
}
