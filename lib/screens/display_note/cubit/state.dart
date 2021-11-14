abstract class DisPlayNoteStates {}

class InitialDisPlayNoteState extends DisPlayNoteStates {}

// delete note states
class DeleteNoteLoadingState extends DisPlayNoteStates {}

class DeleteNoteSuccessState extends DisPlayNoteStates {}

class DeleteNoteErrorState extends DisPlayNoteStates {
  String? message;
  DeleteNoteErrorState({this.message});
}
