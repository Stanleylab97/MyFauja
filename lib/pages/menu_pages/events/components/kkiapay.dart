import 'package:flutter/material.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:myfauja/pages/menu_pages/events/components/success_screen.dart';


class PaiementInscription extends StatelessWidget {
  late bool typeAvocat;
   PaiementInscription({required this.typeAvocat});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        minWidth: 250.0,
        height: 60.0,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF26CD27)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: const Text(
            'Payer mon inscription',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => typeAvocat?kkiapay_avocat:kkiapay_stagiaire),
            );
          },
        ),
      ),
    );
  }
}

void sucessCallback(response, context) {
  print(response);
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SuccessScreen(
        amount: response['amount'],
        transactionId: response['transactionId'],
      ),
    ),
  );
}

final kkiapay_avocat = KKiaPay(
  amount: 1,
  phone: '97000000',
  data: 'Congres VI',
  sandbox: false,
  apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
  callback: sucessCallback,
  name: 'JOHN DOE',
  theme: "#50994a",
);

final kkiapay_stagiaire = KKiaPay(
  amount: 50000,
  phone: '97000000',
  data: 'Congres VI',
  sandbox: false,
  apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
  callback: sucessCallback,
  name: 'JOHN DOE',
  theme: "#E30E25",
);