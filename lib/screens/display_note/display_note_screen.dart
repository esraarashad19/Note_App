import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/display_note/cubit/cubit.dart';
import 'package:notes_app/screens/display_note/cubit/state.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/screens/pdf/pdf_screen.dart';
import 'package:notes_app/shared/components/messages_box.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class DisplayNoteScreen extends StatelessWidget {
  NoteModel note;
  DisplayNoteScreen(this.note);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DisplayNoteCubit(),
      child: BlocConsumer<DisplayNoteCubit, DisPlayNoteStates>(
        listener: (context, state) {
          if (state is DeleteNoteSuccessState) {
            showMessageBox(
              message: 'successfully deleted',
              title: '',
              context: context,
              onPress: () {
                navigateAndFinish(
                  context: context,
                  nextScreen: NotesScreen(),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                  'YOUR NOTE HERE',
                  style: TextStyle(
                    color: appGreyColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      DisplayNoteCubit.get(context).deleteNote(note.noteId!);
                    },
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            note.name,
                            style: titleTextStyle,
                          ),
                        ),
                      ],
                    ),
                    if (note.attachType == 'photo' &&
                        note.attachmentFile != null)
                      Container(
                        width: screenWidth,
                        height: screenHeight / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[50],
                          image: DecorationImage(
                            image: NetworkImage(note.attachmentFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (note.attachType == 'file' &&
                        note.attachmentFile != null)
                      GestureDetector(
                        onTap: () {
                          navigateTo(
                            context: context,
                            nextScreen: PdfScreen(
                              note.attachmentFile!,
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image(
                                image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGYvvQ2B2VSP7yR21udNbf-Z-z3rd768cXYQ&usqp=CAU',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (note.note != null && note.note!.isNotEmpty)
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              note.note!,
                              //note.note!,
                              style: TextStyle(fontSize: 18, height: 1.4),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is DeleteNoteLoadingState)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
