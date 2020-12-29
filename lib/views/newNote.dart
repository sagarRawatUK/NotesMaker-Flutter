import 'package:NotesApp/constants/constants.dart';
import 'package:NotesApp/helper/database.dart';
import 'package:NotesApp/models/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  Note note = Note('', '', 0);
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    note.priority = 1;
    note.title = titleTextController.text;
    note.description = descriptionTextController.text;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result = await databaseHelper.insertNote(note);
    // if (result != 0) {
    //   _showSnackBar(context, "Note Saved");
    // } else {
    //   _showSnackBar(context, "Error Saving Note");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Create New Note",
          style: appBarTextStyle(),
        ),
      ),
      body: Container(
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: TextFormField(
                style: inputTextStyle(),
                controller: titleTextController,
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextField(
                    style: inputTextStyle(),
                    controller: descriptionTextController,
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
                    Navigator.pop(context,true);
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
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
}
