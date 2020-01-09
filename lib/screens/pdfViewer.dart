import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
class PdfViewer extends StatefulWidget {
  static const String id="pdfViewer.dart";
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading=false,_isInit=true;
  PDFDocument document;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:Center(child:_isInit?Text('Load PDF file'):_isLoading?Center(
                child: CircularProgressIndicator(),
              ):PDFViewer(
                document:document
              ))
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: MaterialButton(
                  child: Text('ASSETS'),
                  onPressed: (){
                    loadFromAsset();
                  },
                ),),
                Expanded(child: MaterialButton(
                  child: Text('URL'),
                  onPressed: (){
                    loadFromURL();
                  },
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
  loadFromAsset() async{
    setState(() {
      _isInit=false;
      _isLoading =true;
    });
    document=await PDFDocument.fromAsset("pdf/ThreeBoat.pdf");
    setState(() {
      _isLoading=false;
    });
  }

  loadFromURL() async{
    setState(() {
      _isInit=false;
      _isLoading =true;
    });
    document=await PDFDocument.fromURL("assets/pdf/ThreeBoat.pdf");
    setState(() {
      _isLoading=false;
    });
  }
}
