abstract class OpenPdfStates {}

class InitialOpenPdfState extends OpenPdfStates {}

class OpenPdfLoadingState extends OpenPdfStates {}

class OpenPdfSuccessState extends OpenPdfStates {}

class OpenPdfErrorState extends OpenPdfStates {
  String? message;
  OpenPdfErrorState({this.message});
}
