import 'package:floor/floor.dart';
import 'package:notes/dao/note_dao.dart';
import 'package:notes/dao/todo_item_dao.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/entity/todo_item.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Note, TodoItem])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
  TodoItemDao get todoItemDao;
}
