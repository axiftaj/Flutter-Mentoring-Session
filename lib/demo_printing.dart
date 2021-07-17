import 'dart:io';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DemoPrinting extends StatefulWidget {
  static const String id = 'DemoPrinting' ;

  String path ;
  DemoPrinting({required this.path});

  @override
  _DemoPrintingState createState() => _DemoPrintingState();
}

class _DemoPrintingState extends State<DemoPrinting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Print' ,)),
      body: Column(
        children: [
          Expanded(
            child: PdfPreview(
              build: (format) => _generatePdf(format, 'Print'),
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      File(widget.path).readAsBytesSync(),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [

              pw.Padding(
                padding:  pw.EdgeInsets.symmetric(vertical: 0),
                child:  pw. Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                        height: 500 ,
                        width: 500,
                        child: pw.Image(
                            image)
                    )

                  ],
                ),
              ),


            ],
          );
        },
      ),
    );

    return pdf.save();
  }

}