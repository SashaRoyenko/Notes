// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao _noteDaoInstance;

  TodoItemDao _todoItemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `notes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `text` TEXT NOT NULL, `json_formatted_text` TEXT NOT NULL, `update_date` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo_items` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `text` TEXT NOT NULL, `update_date` TEXT NOT NULL, `is_done` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  TodoItemDao get todoItemDao {
    return _todoItemDaoInstance ??= _$TodoItemDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'notes',
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'json_formatted_text': item.jsonFormattedText,
                  'update_date': item.updateDate
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'notes',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'json_formatted_text': item.jsonFormattedText,
                  'update_date': item.updateDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  @override
  Future<List<Note>> findAllNotesOrderByUpdateDate() async {
    return _queryAdapter.queryList(
        'SELECT * FROM notes ORDER BY update_date DESC',
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['text'] as String,
            row['json_formatted_text'] as String,
            row['update_date'] as String));
  }

  @override
  Future<void> deleteNote(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM notes WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }
}

class _$TodoItemDao extends TodoItemDao {
  _$TodoItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _todoItemInsertionAdapter = InsertionAdapter(
            database,
            'todo_items',
            (TodoItem item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'update_date': item.updateDate,
                  'is_done': item.isDone ? 1 : 0
                }),
        _todoItemUpdateAdapter = UpdateAdapter(
            database,
            'todo_items',
            ['id'],
            (TodoItem item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'update_date': item.updateDate,
                  'is_done': item.isDone ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoItem> _todoItemInsertionAdapter;

  final UpdateAdapter<TodoItem> _todoItemUpdateAdapter;

  @override
  Future<List<TodoItem>> findAllTodoItemsOrderByUpdateDate() async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo_items ORDER BY is_done, update_date',
        mapper: (Map<String, dynamic> row) => TodoItem(
            row['id'] as int,
            row['text'] as String,
            row['update_date'] as String,
            (row['is_done'] as int) != 0));
  }

  @override
  Future<void> deleteTodoItem(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM todo_items WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertTodoItem(TodoItem note) async {
    await _todoItemInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTodoItem(TodoItem note) async {
    await _todoItemUpdateAdapter.update(note, OnConflictStrategy.abort);
  }
}
