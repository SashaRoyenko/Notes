import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/entity/note.dart';
import 'package:notes/service/note_service.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';

class AddNotePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddNotePageWidgetState();
}

class _AddNotePageWidgetState extends State<AddNotePageWidget> {
  NoteService _noteService = NoteService();

  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(NotusDocument());
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    _noteService = Provider.of<NoteService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _saveNote();
            navigator.pop();
          },
          icon: Icon(Icons.keyboard_backspace),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }

  void _saveNote() {
    String plainText = _controller.document.toPlainText();
    String jsonFormatText = _controller.document.toJson().toString();
    String createdDate = DateTime.now().toIso8601String();
    Note note = Note(null, plainText, jsonFormatText, createdDate);
    _noteService.insertNote(note);
  }
}
