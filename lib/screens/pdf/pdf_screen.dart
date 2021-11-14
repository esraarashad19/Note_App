import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:notes_app/screens/pdf/cubit/cubit.dart';
import 'package:notes_app/screens/pdf/cubit/states.dart';
import 'package:notes_app/shared/constrains.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfScreen extends StatelessWidget {
  var pdfPath;

  PdfScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    print(pdfPath);
    return BlocProvider(
      create: (context) => OpenPdfCubit()..getPdf(pdfPath),
      child: BlocConsumer<OpenPdfCubit, OpenPdfStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = OpenPdfCubit.get(context);
          return Scaffold(
            // backgroundColor: Colors.white,
            //backgroundColor: Colors.grey[50],
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.grey[100],
              iconTheme: IconThemeData(
                color: appGreyColor,
              ),
              bottom: AppBar(
                elevation: 4,
                leadingWidth: 0,
                shadowColor: Colors.grey[100]!.withOpacity(.1),
                toolbarHeight: 40,
                backgroundColor: Colors.grey[100],
                title: Text(
                  'Your File',
                  style: appBarTextStyle,
                ),
                iconTheme: IconThemeData(
                  color: Colors.grey[100],
                ),
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.doc != null,
              widgetBuilder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PDFViewer(
                    document: OpenPdfCubit.get(context).doc,
                  ),
                );
              },
              fallbackBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
