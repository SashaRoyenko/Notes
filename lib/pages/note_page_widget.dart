import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/pages/parts/note_item_widget.dart';
import 'package:notes/service/note_service.dart';
import 'package:provider/provider.dart';

class NotePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePageWidget> {

  NoteService _noteService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      _noteService = Provider.of<NoteService>(context);
      return FutureBuilder<List<Note>>(
          future: _noteService.findAllNotesOrderByUpdateDate(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? _notesGrid(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }
    );
  }

  Widget _notesGrid(List<Note> notes) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        final DateFormat formatter = DateFormat('dd MMMM');
        String formattedDate = formatter.format(DateTime.parse(notes[index].updateDate));
        return NoteItemWidget(notes[index].text, formattedDate);
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
    );
  }
}
