import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/pages/parts/note_item_widget.dart';

class NotePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePageWidget> {
//  List<NoteItemWidget> _notes = _getWidgets();

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) => _getWidgets()[index],
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.fit(1),
    );
  }

  List<NoteItemWidget> _getWidgets() {
    List<NoteItemWidget> notes =
        List.generate(10, (index) => NoteItemWidget("Short text"));
    notes.addAll(List.generate(
        10,
        (index) => NoteItemWidget(
            '''A lot of energy is squandered because the different parts of our lives, both internal and external, are in conflict with each other. That could be the colleague at work who doesn’t want you to get promoted, the friends who make fun of your goals or even the internal fears and assumptions that keep you hesitating.
Spend some time untangling the different conflicts in your life to see how you could resolve them. Sometimes that can be done in the short-term, by making a change. Sometimes, it requires a long-term plan to escape the toxic environment, social circle or belief system that holds you back.''')));
    notes.shuffle(Random.secure());
    return notes;
  }
}
