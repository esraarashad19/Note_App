abstract class NotesStates {}

class InitialNoteState extends NotesStates {}

//get notes states
class GetNotesLoadingState extends NotesStates {}

class GetNotesSuccessState extends NotesStates {}

class GetNotesErrorState extends NotesStates {
  String? message;
  GetNotesErrorState(this.message);
}
