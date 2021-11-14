import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/screens/display_note/cubit/state.dart';
import 'package:notes_app/shared/constrains.dart';

class DisplayNoteCubit extends Cubit<DisPlayNoteStates> {
  DisplayNoteCubit() : super(InitialDisPlayNoteState());
  static DisplayNoteCubit get(context) => BlocProvider.of(context);

  void deleteNote(String noteId) {
    emit(DeleteNoteLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .delete()
        .then((value) {
      emit(DeleteNoteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteNoteErrorState());
    });
  }
}
