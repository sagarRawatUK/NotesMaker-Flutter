import 'package:NotesApp/constants/constants.dart';
import 'package:NotesApp/helper/database.dart';
import 'package:NotesApp/models/note.dart';
import 'package:NotesApp/views/editNote.dart';
import 'package:flutter/material.dart';

DatabaseHelper databaseHelper = DatabaseHelper();

class ViewNote extends StatefulWidget {
  Note note;
  ViewNote(this.note);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  void _deleteNote(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    // if (result != 0) {
    //   _showSnackBar(context, "Note Deleted");
    // } else {
    //   _showSnackBar(context, "Error Deleting Note");
    // }

    Navigator.pop(context, true);
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "",
          style: appBarTextStyle(),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteEditor(widget.note)));
              }),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteNote(context, widget.note);
              })
        ],
      ),
      body: Builder(builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: textFieldColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: Text(
                  widget.note.title,
                  style: titleTextStyle(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textFieldColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Text(
                    widget.note.description,
                    style: titleTextStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      }),
    );
  }
}
