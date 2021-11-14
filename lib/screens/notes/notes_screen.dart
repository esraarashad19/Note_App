import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/add_note/add_note_screen.dart';

import 'package:notes_app/screens/display_note/display_note_screen.dart';
import 'package:notes_app/screens/drawer/drawer_screen.dart';
import 'package:notes_app/screens/notes/cubit/cubit.dart';
import 'package:notes_app/screens/notes/cubit/states.dart';

import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class NotesScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotesCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.grey[100],
            iconTheme: IconThemeData(
              color: appGreyColor,
            ),
            bottom: AppBar(
              elevation: 4,
              leadingWidth: 0,
              shadowColor: Colors.grey[100]!.withOpacity(.1),
              toolbarHeight: 40,
              backgroundColor: Colors.grey[100],
              title: Text(
                'ALL NOTES',
                style: TextStyle(
                  color: appGreyColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: PopupMenuButton<String>(
                    padding: EdgeInsetsDirectional.only(top: 48),
                    onSelected: (value) {
                      print(value);
                      cubit.getNotes(
                          orderby: value == 'sort by name' ? 'name' : null);
                    },
                    itemBuilder: (BuildContext context) {
                      return {'sort by date', 'sort by name'}
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    child: Icon(
                      Icons.saved_search,
                      color: appGreyColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.grey[100],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: cubit.notesList.length > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildNote(cubit.notesList[index], context);
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: appGreyColor,
                      ),
                      itemCount: cubit.notesList.length,
                    )
                  : emptyNoteUi(
                      screenWidth: screenWidth,
                    ),
            ),
          ),
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context: context, nextScreen: AddNoteScreen());
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

Widget emptyNoteUi({required double screenWidth}) => Container(
      width: screenWidth,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/note1.png'),
              ),
            ),
          ),
          Text(
            'Create Your First Notes!',
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Tap + to create a note. Take a photo, add an attachment or type some text',
            style: TextStyle(
              fontSize: 16,
              color: appGreyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

Widget buildNote(NoteModel note, context) {
  // print('note type is ${note.attachType}');
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: () {
        navigateTo(context: context, nextScreen: DisplayNoteScreen(note));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (note.date as Timestamp).toDate().toString(),
                style: TextStyle(
                  color: appGreyColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                note.name,
                style: titleTextStyle,
              ),
            ],
          ),
          if (note.attachmentFile != null)
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                image: note.attachType == 'file'
                    ? DecorationImage(
                        image: NetworkImage(
                          'https://www.thoughtco.com/thmb/5H3oOzmc1-eWXquZAH4DYyMBGEs=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/Pdf_by_mimooh.svg-56a9d1943df78cf772aaca04.jpg',
                        ),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage(note.attachmentFile!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
        ],
      ),
    ),
  );
}
