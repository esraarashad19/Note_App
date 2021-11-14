import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/add_note/cubit/states.dart';
import 'package:notes_app/shared/constrains.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddNoteCubit extends Cubit<AddNoteStates> {
  AddNoteCubit() : super(InitialAddNoteState());
  static AddNoteCubit get(context) => BlocProvider.of(context);

  NoteModel? noteModel;
  ImagePicker picker = ImagePicker();
  File? pickedFile;
  String? fileName;
  File? pickedImage;
  // String? imageURL;
  String? fileURL;
  String? attachment;
  var ext;

  TextEditingController nameController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  bool isBottomSheetOpen = false;

  // open or close bottom sheet
  void changeBottomSheet(bool value) {
    isBottomSheetOpen = value;
    emit(BottomSheetState());
  }

  void picFile() {
    FilePicker.platform.pickFiles().then((value) {
      ext = value!.files.first.extension;
      if (ext == 'pdf') {
        pickedFile = File(value.files.single.path!);
        fileName = value.files.first.name;
        attachment = 'file';
        print('file is pdf');
        emit(PickFileSuccessState());
      } else if (ext == 'jpg' || ext == 'png' || ext == 'jpeg') {
        pickedImage = File(value.files.single.path!);
        fileName = value.files.first.name;
        attachment = 'photo';
        print('file is image');
        emit(PickImageSuccessState());
      }
      uploadFile();
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  // upload file
  void uploadFile() {
    emit(UploadFileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('notesFiles/$fileName')
        .putFile(pickedFile != null ? pickedFile! : pickedImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        fileURL = value;
        print('file url : $fileURL');
        emit(UploadFileSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadFileErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadFileErrorState());
    });
  }

  addNote() {
    emit(AddNoteLoadingState());
    noteModel = NoteModel(
      attachType: attachment,
      name: nameController.text,
      date: DateTime.now(),
      note: noteTextController.text,
      attachmentFile: fileURL,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .add(noteModel!.toMap())
        .then((value) {
      print(value.id);
      updateNoteId(value.id);
      emit(AddNoteSuccessState());
    }).catchError((error) {
      emit(AddNoteErrorState(error.toString()));
      print(error.toString());
    });
  }

  // update note id
  updateNoteId(String id) {
    noteModel!.noteId = id;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(id)
        .update(noteModel!.toMap())
        .then((value) {
      noteTextController.clear();
      nameController.clear();
      fileURL = null;
      pickedFile = null;
      pickedImage = null;
      attachment = null;
      emit(UpdateNoteIdSuccessState());
    }).catchError((error) {
      emit(UpdateNoteIdErrorState(error.toString()));
      print(error.toString());
    });
  }
}
