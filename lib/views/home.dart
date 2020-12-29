import 'package:NotesApp/constants/constants.dart';
import 'package:NotesApp/helper/database.dart';
import 'package:NotesApp/models/note.dart';
import 'package:NotesApp/views/newNote.dart';
import 'package:NotesApp/views/viewNote.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(
          //   Icons.edit,
          //   color: themeMainColor,
          // ),
          elevation: 0,
          title: Text(
            "Notes",
            style: appBarTextStyle(),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: bgColor,
          child: Container(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(this.noteList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () async {
                      bool result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewNote(this.noteList[index])));
                      setState(() {
                        updateListView();
                      });
                    },
                    child: Card(
                      color: colorList[(index % colorList.length)],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                this.noteList[index].title,
                                style: titleTextStyle(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: borderColor,
                                  )),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  // getPriorityWidget(
                                  //     this.noteList[index].priority),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    this.noteList[index].date,
                                    style: timeTextStyle(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  this.noteList[index].description,
                                  overflow: TextOverflow.fade,
                                  style: descriptionTextStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeMainColor,
          onPressed: () async {
            bool result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewNote()));
            if (result) {
              setState(() {
                updateListView();
              });
            }
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  Widget getPriorityWidget(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.notifications_active);
      case 2:
        return Icon(Icons.notifications);
      default:
        return Icon(Icons.notifications);
    }
  }
}
