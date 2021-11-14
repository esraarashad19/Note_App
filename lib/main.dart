import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/screens/login/login_screen.dart';
import 'package:notes_app/screens/notes/cubit/cubit.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/screens/profile/cubit/cubit.dart';
import 'package:notes_app/shared/my_bloc_observer.dart';
import 'package:notes_app/shared/constrains.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user != null) {
      print('User is signed in!');
      currentUser = user;
    } else {
      print('User is currently signed out!');
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => NotesCubit()..getNotes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        home: currentUser == null ? LoginScreen() : NotesScreen(),
        //home: DisplayNoteScreen(),
      ),
    );
  }
}
