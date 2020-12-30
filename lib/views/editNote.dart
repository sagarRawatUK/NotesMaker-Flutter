import 'package:NotesApp/constants/constants.dart';
import 'package:NotesApp/helper/database.dart';
import 'package:NotesApp/models/note.dart';
import 'package:NotesApp/views/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteEditor extends StatefulWidget {
  Note oldNote;
  NoteEditor(this.oldNote);

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  Note note;
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    note = Note.withId(widget.oldNote.id, "", "", 1);
    note.priority = 1;
    note.title = titleTextController.text;
    note.description = descriptionTextController.text;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result = await databaseHelper.updateNote(note);
    // if (result != 0) {
    //   _showSnackBar(context, "Note Saved");
    // } else {
    //   _showSnackBar(context, "Error Saving Note");
    // }
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  _updateTitle() {
    note.title = titleTextController.text;
  }

  _updateDescription() {
    note.title = descriptionTextController.text;
  }

  @override
  Widget build(BuildContext context) {
    titleTextController.text = widget.oldNote.title;

    descriptionTextController.text = widget.oldNote.description;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Edit Note",
          style: appBarTextStyle(),
        ),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: textFieldColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  onChanged: (text) => _updateTitle,
                  style: inputTextStyle(),
                  controller: titleTextController,
                  // initialValue: widget.oldNote.title,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: hintTextStyle(),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: TextFormField(
                      onChanged: (text) => _updateDescription,
                      style: inputTextStyle(),
                      controller: descriptionTextController,
                      // initialValue: widget.oldNote.description,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: hintTextStyle(),
                        border: InputBorder.none,
                      ),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: textFieldColor),
                      child: Text(
                        "Cancel",
                        style: buttonTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _saveNote();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: themeMainColor),
                      child: Text(
                        "Save",
                        style: buttonTextStyle(),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
