import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/login/login_screen.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/screens/register/cubit/cubit.dart';
import 'package:notes_app/screens/register/cubit/states.dart';
import 'package:notes_app/shared/components/customes_shapes_classes.dart';
import 'package:notes_app/shared/components/defualt_rounded_button.dart';
import 'package:notes_app/shared/components/defualt_text_field.dart';
import 'package:notes_app/shared/components/messages_box.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState)
            showMessageBox(message: state.message, context: context);
          if (state is SetUserSuccessState)
            showMessageBox(
                message: 'successfully registered',
                context: context,
                onPress: () {
                  navigateAndFinish(
                      context: context, nextScreen: LoginScreen());
                });
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFF04BAF8),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFF04BAF8),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  CustomPaint(
                    painter: WaveContainer(),
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                    ),
                  ),
                  CustomPaint(
                    painter: SecondWaveContainer(),
                    child: Container(
                      height: screenHeight,
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: screenHeight / 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/note.png'),
                                    color: Colors.white,
                                    width: screenWidth * .15,
                                    height: screenHeight * .15,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'N O T E S',
                                    style: mainHeadLineTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight / 4,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        DefualtTextField(
                                          hint: 'Name',
                                          controller: cubit.nameController,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DefualtTextField(
                                          hint: 'Email ID',
                                          controller: cubit.emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DefualtTextField(
                                          hint: 'Password',
                                          controller: cubit.passwordController,
                                          isPassword: true,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DefualtTextField(
                                          hint: 'Confirm Password',
                                          controller: cubit.confirmController,
                                          isPassword: true,
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              if (state is! RegisterLoadingState)
                                DefualtRoundedButton(
                                  title: 'Register',
                                  onpress: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).register();
                                    }
                                  },
                                ),
                              if (state is RegisterLoadingState)
                                Center(child: CircularProgressIndicator()),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Have an account?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      navigateAndFinish(
                                        context: context,
                                        nextScreen: LoginScreen(),
                                      );
                                    },
                                    child: Text(
                                      'LOGIN HERE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
