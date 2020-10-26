import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/factory/app_bar_factory.dart';
import 'package:notes/pages/parts/note_item_widget.dart';
import 'package:notes/service/note_service.dart';
import 'package:notes/state/app_bar_state.dart';
import 'package:provider/provider.dart';

class NotePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePageWidget>
    with AutomaticKeepAliveClientMixin<NotePageWidget> {
  NoteService _noteService;
  Set<Note> selectedNotes = Set();
  AppBarState _appBarState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _noteService = Provider.of<NoteService>(context);
    return FutureBuilder<List<Note>>(
        future: _noteService.findAllNotesOrderByUpdateDate(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _notesGrid(snapshot.data, context)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget _notesGrid(List<Note> notes, context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return NoteItemWidget(
            note: notes[index],
            isSelected: selectedNotes.contains(notes[index]) ? true : false,
            isAnySelected: selectedNotes.length > 0,
            key: Key(notes[index].id.toString()),
            isSelectedCallback: (bool value) {
              if (value) {
                selectedNotes.add(notes[index]);
              } else {
                selectedNotes.remove(notes[index]);
              }
              _appBarState = Provider.of<AppBarState>(context);
              if (selectedNotes.length > 0) {
                AppBar appBar = AppBarFactory.multiSelectDeleteAppBar(
                    selectedNotes.length, _deleteNotes);
                _appBarState.appBar = appBar;
              } else {
                _appBarState.appBar = _appBarState.mainBar;
              }
            });
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
    );
  }

  void _deleteNotes() {
    setState(() {
      selectedNotes.forEach((element) {
        _noteService.delete(element.id);
      });
      selectedNotes = Set();
      _appBarState.appBar = _appBarState.mainBar;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
