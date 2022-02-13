import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
      final GlobalKey<SlideActionState> _key = GlobalKey();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SlideAction(
          key: _key,
          onSubmit: () {
            Future.delayed(
              Duration(seconds: 1),
                  () => _key.currentState!.reset(),
            );
          },
          submittedIcon: FaIcon(
            FontAwesomeIcons.phone,
            color: Colors.blue,
          ),
        ),
      );
    },
  );
}