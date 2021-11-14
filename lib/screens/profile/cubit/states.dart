abstract class ProfileStates {}

class InitialProfileState extends ProfileStates {}

class GetUserLoadingState extends ProfileStates {}

class GetUserSuccessState extends ProfileStates {}

class GetUserErrorState extends ProfileStates {
  String message;
  GetUserErrorState(this.message);
}

class PickImageSuccessState extends ProfileStates {}

// upload user image
class UploadImageLoadingState extends ProfileStates {}

class UploadImageSuccessState extends ProfileStates {}

class UploadImageErrorState extends ProfileStates {}

// update user data
class UpdateUserDataSuccessState extends ProfileStates {}

class UpdateUserDataErrorState extends ProfileStates {}
