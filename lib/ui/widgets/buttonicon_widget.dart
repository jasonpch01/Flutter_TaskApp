import 'package:flutter/material.dart';
import 'package:flutter_apptask/ui/general/colors.dart';

class WidgetButtonIcon extends StatelessWidget {
  String texto;
  Function onPressed;

  WidgetButtonIcon({required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            primary: kBrandPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        icon: Icon(Icons.save),
        label: Text(
          texto,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
