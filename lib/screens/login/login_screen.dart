import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/login/cubit/cubit.dart';
import 'package:notes_app/screens/login/cubit/states.dart';
import 'package:notes_app/screens/notes/notes_screen.dart';
import 'package:notes_app/screens/register/register_screen.dart';
import 'package:notes_app/shared/components/customes_shapes_classes.dart';
import 'package:notes_app/shared/components/defualt_rounded_button.dart';
import 'package:notes_app/shared/components/defualt_text_field.dart';
import 'package:notes_app/shared/components/messages_box.dart';
import 'package:notes_app/shared/components/navigations.dart';
import 'package:notes_app/shared/constrains.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState)
            showMessageBox(message: state.message, context: context);
          if (state is LoginSuccessState)
            navigateAndFinish(context: context, nextScreen: NotesScreen());
        },
        builder: (context, state) {
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
                      child: Column(
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    DefualtTextField(
                                      hint: 'Email ID',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefualtTextField(
                                      hint: 'Password',
                                      controller: passwordController,
                                      isPassword: true,
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          if (state is! LoginLoadingState)
                            DefualtRoundedButton(
                              title: 'Login',
                              onpress: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                          if (state is LoginLoadingState)
                            Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context: context,
                                    nextScreen: RegisterScreen(),
                                  );
                                },
                                child: Text(
                                  'SIGN UP HERE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
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
