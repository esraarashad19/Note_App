import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/add_note/cubit/cubit.dart';
import 'package:notes_app/screens/add_note/cubit/states.dart';
import 'package:notes_app/screens/notes/cubit/cubit.dart';
import 'package:notes_app/screens/notes/cubit/states.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/shared/components/defualt_circular_button.dart';
import 'package:notes_app/shared/components/defualt_rounded_button.dart';
import 'package:notes_app/shared/components/messages_box.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';
import 'package:open_file/open_file.dart';

class AddNoteScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteStates>(
        listener: (context, state) {
          if (state is AddNoteSuccessState)
            showMessageBox(
              message: 'Successfully Added',
              context: context,
              onPress: () {
                navigateAndFinish(
                  context: context,
                  nextScreen: NotesScreen(),
                );
              },
              title: 'success',
            );
          if (state is AddNoteErrorState)
            showMessageBox(
              message: state.message,
              context: context,
            );
        },
        builder: (context, state) {
          var cubit = AddNoteCubit.get(context);
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
                  'Add NOTE',
                  style: TextStyle(
                    color: appGreyColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.attachment_outlined,
                      color: appGreyColor,
                      size: 25,
                    ),
                    onPressed: () {
                      AddNoteCubit.get(context).picFile();
                    },
                  ),
                  if (cubit.pickedFile != null ||
                      cubit.pickedImage != null ||
                      cubit.noteTextController.text != '' ||
                      cubit.noteTextController.text != null)
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: appGreyColor,
                        size: 30,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addNote();
                          NotesCubit.get(context)..getNotes();
                        }
                      },
                    ),
                ],
                iconTheme: IconThemeData(
                  color: Colors.grey[100],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: cubit.nameController,
                      style: profileDataTextStyle,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.photo_album_outlined,
                          size: 40,
                        ),
                        hintText: 'Add Note Name',
                        hintStyle: TextStyle(
                          color: appGreyColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200]!,
                            width: 2.5,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey[200]!,
                          width: 2.5,
                        )),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Name is required';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        if (cubit.pickedFile != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: cubit.fileURL != null
                                  ? Image(
                                      image: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGYvvQ2B2VSP7yR21udNbf-Z-z3rd768cXYQ&usqp=CAU',
                                      ),
                                    )
                                  : Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        if (cubit.pickedImage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth,
                              height: screenHeight / 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[50],
                              ),
                              child: cubit.fileURL != null
                                  ? Image(
                                      image: Image.file(
                                        File(cubit.pickedImage!.path),
                                      ).image,
                                      fit: BoxFit.cover,
                                    )
                                  : Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: cubit.noteTextController,
                            decoration: InputDecoration(
                              hintText: 'Enter your note ',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            minLines: 2,
                            maxLines: null,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  if (state is AddNoteLoadingState)
                    Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
