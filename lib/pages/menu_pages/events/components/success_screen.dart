import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  String transactionId;
  int amount;
  SuccessScreen({required this.amount, required this.transactionId});

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/images/programme.pdf');

    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Inscription enregistrée!')
      ),
    );
  }
}