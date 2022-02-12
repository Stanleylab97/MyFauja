import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:myfauja/models/participant.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SuccessScreen extends StatefulWidget {
  String transactionId, numero_Inscrption;
  int amount;
  Participant participant;
  SuccessScreen({required this.amount, required this.transactionId,required this.participant, required this.numero_Inscrption});

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  void initState() {
    super.initState();

  }

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary!.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:
          Column(
            children: [
              Expanded(
                child:  Center(
                  child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: widget.numero_Inscrption,
                        size: 0.5 * bodyHeight,
                        embeddedImage: AssetImage('assets/images/logos/logo.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(80, 80),
                        ),
                        errorStateBuilder:
                            (cxt, err) {
                          return Container(
                            child: Center(
                              child: Text(
                                "Votre inscription est validée mais le code ne peut s'afficher",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      )
                  ),
                ),
              ),
              
              SizedBox(height: getProportionateScreenHeight(25)),
              Text("Merci à vous Me ${widget.participant.nom} et à très vite!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
              SizedBox(height: getProportionateScreenHeight(25)),
              Text("Votre QR code vous sera demandé à l'entrée du congrès.", textAlign: TextAlign.center)

            ],
          ),

    );
  }
}