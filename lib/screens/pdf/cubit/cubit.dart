import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/pdf/cubit/states.dart';

class OpenPdfCubit extends Cubit<OpenPdfStates> {
  OpenPdfCubit() : super(InitialOpenPdfState());
  static OpenPdfCubit get(context) => BlocProvider.of(context);
  var doc;
  void getPdf(String path) {
    emit(OpenPdfLoadingState());
    PDFDocument.fromURL(path).then((value) {
      doc = value;
      emit(OpenPdfSuccessState());
    }).catchError((error) {
      emit(OpenPdfErrorState(message: error.text));
    });
  }
}
