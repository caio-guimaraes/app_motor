import 'package:app_motor/home/home_page.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CustomGradientButton extends StatelessWidget {
  String text = '';
  String nextPage = '/';
  CustomGradientButton(this.text, this.nextPage);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        (nextPage != null)
            ? Navigator.pushReplacementNamed(context, nextPage)
            : debugPrint('Button without route');
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PrimaryBlue3, SecondaryBlue1],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: FontNameDefaultTitle,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
