import 'package:notes/dao/note_dao.dart';

import 'app_database.dart';

class DaoFactory {

  static AppDatabase _database;

  NoteDao _noteDao;

  static final DaoFactory _instance = DaoFactory._();

  DaoFactory._() {
  }

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

}
