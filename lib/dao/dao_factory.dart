import 'package:notes/dao/note_dao.dart';
import 'package:notes/dao/todo_item_dao.dart';

import '../database/app_database.dart';

class DaoFactory {

  static AppDatabase _database;

  NoteDao _noteDao;

  TodoItemDao _todoItemDao;

  static final DaoFactory _instance = DaoFactory._();

  DaoFactory._();

  static setUp() async {
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  static getInstance() async {
    if(_database == null) {
      await setUp();
    }
    return _instance;
  }

  get noteDao {
    if (_noteDao == null) {
      _noteDao = _database.noteDao;
    }
    return _noteDao;
  }

  get todoItemDao {
    if (_todoItemDao == null) {
      _todoItemDao = _database.todoItemDao;
    }
    return _todoItemDao;
  }
}
