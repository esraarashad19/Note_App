import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/models/user_model.dart';
import 'package:notes_app/screens/profile/cubit/states.dart';
import 'package:notes_app/shared/constrains.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  String? URL;

  var userNameController;
  var emailController;
  var mobileController;
  var fulnameController;

  // select image from gallery to set it as profile photo
  void picImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      print(value!.path);
      imageFile = value;
      uploadProfileImage();
      emit(PickImageSuccessState());
    });
  }

// upload selected image to firebase storage
  void uploadProfileImage() {
    emit(UploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(File(imageFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        URL = value;
        // updateUserData(url: value);
      }).catchError((error) {});
      emit(UploadImageSuccessState());
    }).catchError((error) {
      emit(UploadImageErrorState());
      print(error.toString());
    });
  }

  // update user data
  updateUserData() {
    userModel = UserModel(
      id: currentUser!.uid,
      username: userNameController.text,
      email: emailController.text,
      fullName: fulnameController.text,
      phone: mobileController.text,
      image: URL != null ? URL! : userModel!.image,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update(userModel!.toMap())
        .then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
      print(error.toString());
    });
  }

//get user data
  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);
      userNameController = TextEditingController(text: userModel!.username);
      emailController = TextEditingController(text: userModel!.email);
      mobileController = TextEditingController(text: userModel!.phone);
      fulnameController = TextEditingController(text: userModel!.fullName);

      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
      print(error.toString());
    });
  }
}
