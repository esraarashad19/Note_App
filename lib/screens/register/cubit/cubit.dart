import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/user_model.dart';
import 'package:notes_app/screens/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/shared/constrains.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmController = TextEditingController();

  void register() {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      currentUser = value.user!;
      setUserData(uid: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  // save user data in firestore
  void setUserData({required String uid}) {
    UserModel userModel = UserModel(
      id: uid,
      email: emailController.text,
      username: nameController.text,
      fullName: nameController.text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(SetUserSuccessState());
      nameController.clear();
      confirmController.clear();
      emailController.clear();
      passwordController.clear();
    }).catchError((error) {
      emit(SetUserErrorState(error.toString()));
      print(error.toString());
    });
  }
}
