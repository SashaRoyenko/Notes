import 'package:floor/floor.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/enums/sql_scripts.dart';

@dao
abstract class NoteDao {
  @Query(SqlScripts.SELECT_NOTES_ORDER_BY_UPDATE_DATE)
  Future<List<Note>> findAllNotesOrderByUpdateDate();

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @Query(SqlScripts.DELETE_NOTE_BY_ID)
  Future<void> deleteNote(int id);
}