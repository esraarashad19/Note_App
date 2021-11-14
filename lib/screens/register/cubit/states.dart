abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  String message;
  RegisterErrorState(this.message);
}

class SetUserSuccessState extends RegisterStates {}

class SetUserErrorState extends RegisterStates {
  String message;
  SetUserErrorState(this.message);
}
