abstract class AddNoteStates {}

class InitialAddNoteState extends AddNoteStates {}

class BottomSheetState extends AddNoteStates {}

// add note states
class AddNoteLoadingState extends AddNoteStates {}

class AddNoteSuccessState extends AddNoteStates {}

class AddNoteErrorState extends AddNoteStates {
  String message;
  AddNoteErrorState(this.message);
}

// update note id
class UpdateNoteIdSuccessState extends AddNoteStates {}

class UpdateNoteIdErrorState extends AddNoteStates {
  String message;
  UpdateNoteIdErrorState(this.message);
}

//pic image state
class PickImageSuccessState extends AddNoteStates {}

// pic file state
class PickFileSuccessState extends AddNoteStates {}

// upload user image
class UploadImageLoadingState extends AddNoteStates {}

class UploadImageSuccessState extends AddNoteStates {}

class UploadImageErrorState extends AddNoteStates {}

// upload file
class UploadFileLoadingState extends AddNoteStates {}

class UploadFileSuccessState extends AddNoteStates {}

class UploadFileErrorState extends AddNoteStates {}
