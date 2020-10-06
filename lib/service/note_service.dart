import 'package:flutter/cupertino.dart';
import 'package:notes/dao/note_dao.dart';
import 'package:notes/database/dao_factory.dart';
import 'package:notes/entity/note.dart';

class NoteService extends ChangeNotifier{

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
      noteDao.insertNote(note);
      notifyListeners();
    }
//    await findAllNotesOrderByUpdateDate()
//        .then((value) => value.forEach((element) {
//              delete(element.id);
//            }));
  }

  Future<void> delete(int id) async {
    DaoFactory daoFactory = await DaoFactory.getInstance();
    NoteDao noteDao = daoFactory.noteDao;
    noteDao.delete(id);
    notifyListeners();
  }
}
