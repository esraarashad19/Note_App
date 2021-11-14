import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:notes_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:notes_app/screens/profile/cubit/cubit.dart';
import 'package:notes_app/screens/profile/cubit/states.dart';
import 'package:notes_app/shared/components/defualt_rounded_button.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          backgroundColor: minDarkBlue,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: minDarkBlue,
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.userModel != null,
            widgetBuilder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      child: Column(
                        children: [
                          //profile photo
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: screenWidth / 4.5,
                            backgroundImage:
                                NetworkImage(cubit.userModel!.image),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // user name
                          Text(
                            cubit.userModel!.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: screenWidth,
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: profileCardSpace,
                                    ),
                                    //user name
                                    Text(
                                      'UserName :',
                                      style: greyTextStyle,
                                    ),
                                    Text(
                                      cubit.userModel!.username,
                                      style: profileDataTextStyle,
                                    ),
                                    SizedBox(
                                      height: profileCardSpace,
                                    ),
                                    //email
                                    Text(
                                      'Email :',
                                      style: greyTextStyle,
                                    ),
                                    Text(
                                      cubit.userModel!.email,
                                      style: profileDataTextStyle,
                                    ),
                                    SizedBox(
                                      height: profileCardSpace,
                                    ),
                                    //full name
                                    Text(
                                      'Full Name :',
                                      style: greyTextStyle,
                                    ),
                                    Text(
                                      cubit.userModel!.fullName,
                                      style: profileDataTextStyle,
                                    ),
                                    SizedBox(
                                      height: profileCardSpace,
                                    ),
                                    //mobile number
                                    Text(
                                      'Mobile Number :',
                                      style: greyTextStyle,
                                    ),
                                    Text(
                                      cubit.userModel!.phone!,
                                      style: profileDataTextStyle,
                                    ),
                                    SizedBox(
                                      height: profileCardSpace,
                                    ),
                                    Center(
                                      child: DefualtRoundedButton(
                                        title: 'Edit Profile',
                                        onpress: () {
                                          navigateTo(
                                            context: context,
                                            nextScreen: EditProfileScreen(),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenHeight / 3.25,
                      right: screenWidth / 4.2,
                      left: screenWidth / 4.2,
                      height: 50,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: minDarkBlue,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
