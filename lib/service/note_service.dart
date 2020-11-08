import 'package:flutter/material.dart';
import 'package:notes/dao/note_dao.dart';
import 'package:notes/entity/note.dart';

import 'file:///D:/KPI/4.1/flutter/notes/lib/dao/dao_factory.dart';

class NoteService extends ChangeNotifier {
  Future<List<Note>> findAllNotesOrderByUpdateDate() async {
    DaoFactory daoFactory = await DaoFactory.getInstance();
    NoteDao noteDao = daoFactory.noteDao;
    return await noteDao.findAllNotesOrderByUpdateDate();
  }

  Future<void> insertNote(Note note) async {
    RegExp regex = RegExp(r'\n*');
    if (note.text.isNotEmpty && regex.stringMatch(note.text).isEmpty) {
      DaoFactory daoFactory = await DaoFactory.getInstance();
      NoteDao noteDao = daoFactory.noteDao;
      if (note.id == null) {
        noteDao.insertNote(note);
      } else {
        updateNote(note);
      }
      notifyListeners();
    } else if (note.id != null) {
      delete(note.id);
    }
  }

  Future<void> updateNote(Note note) async {
    RegExp regex = RegExp(r'\n*');
    if (note.text.isNotEmpty && regex.stringMatch(note.text).isEmpty) {
      DaoFactory daoFactory = await DaoFactory.getInstance();
      NoteDao noteDao = daoFactory.noteDao;
      noteDao.updateNote(note);
      notifyListeners();
    } else {
      delete(note.id);
    }
  }

  Future<void> delete(int id) async {
    DaoFactory daoFactory = await DaoFactory.getInstance();
    NoteDao noteDao = daoFactory.noteDao;
    noteDao.deleteNote(id);
    notifyListeners();
  }
}
