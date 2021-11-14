import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/notes/cubit/states.dart';
import 'package:notes_app/shared/constrains.dart';

enum Payments { Online, Cache }

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(InitialNoteState());
  static NotesCubit get(context) => BlocProvider.of(context);

  List<NoteModel> notesList = [];

  // get notes
  void getNotes({String? orderby}) {
    emit(GetNotesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .orderBy(orderby == null ? 'date' : orderby, descending: false)
        .snapshots()
        .listen((event) {
      notesList = [];
      event.docs.forEach((element) {
        notesList.add(NoteModel.fromMap(element.data()));
      });
      emit(GetNotesLoadingState());
    });
  }
}
