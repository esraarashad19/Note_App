import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:notes_app/screens/login/login_screen.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/screens/profile/cubit/cubit.dart';
import 'package:notes_app/screens/profile/cubit/states.dart';
import 'package:notes_app/screens/profile/profile_screen.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = ProfileCubit.get(context);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: appGreyColor,
                        backgroundImage: NetworkImage(
                          cubit.userModel != null
                              ? cubit.userModel!.image
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6xSz0eMW7GmpKukczOHvPWWGDqaBCqWA-Mw&usqp=CAU',
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        cubit.userModel != null
                            ? cubit.userModel!.username
                            : 'Guest',
                        style: TextStyle(
                          fontSize: 22,
                          color: appGreyColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Container(
            height: 1.5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          buildListTile(
            title: 'Home',
            icon: Icons.home_outlined,
            onPress: () {
              navigateAndFinish(context: context, nextScreen: NotesScreen());
            },
          ),
          buildListTile(
            title: 'Profile',
            icon: Icons.person_outline_outlined,
            onPress: () {
              Navigator.pop(context);
              navigateTo(context: context, nextScreen: ProfileScreen());
            },
          ),
          buildListTile(
            title: 'Edit Profile',
            icon: Icons.edit_outlined,
            onPress: () {
              Navigator.pop(context);
              navigateTo(context: context, nextScreen: EditProfileScreen());
            },
          ),
          if (currentUser != null)
            buildListTile(
              title: 'Log out',
              icon: Icons.logout,
              onPress: () {
                FirebaseAuth.instance.signOut().then((value) {
                  navigateAndFinish(
                    context: context,
                    nextScreen: LoginScreen(),
                  );
                }).catchError((error) {
                  print(error.toString());
                });
              },
            ),
        ],
      ),
    );
  }
}

Widget buildListTile(
        {required String title, required IconData icon, required onPress}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ListTile(
        onTap: onPress,
        leading: Icon(
          icon,
          size: 35,
          color: Colors.blueGrey.shade100,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey.shade100,
          ),
        ),
      ),
    );
