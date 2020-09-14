import 'package:app_motor/home/home_page.dart';
import 'package:app_motor/widgets/custom_gradient_button.dart';
import 'package:app_motor/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class SurveyComplete extends StatelessWidget {
  final String textAppBar;
  final String textSuccess;

  SurveyComplete(this.textAppBar, this.textSuccess);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAppBar,
          style: AppBarStyle,
        ),
        backgroundColor: PrimaryBlue3,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Text(
                      textSuccess,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: PrimaryBlue1,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        fontFamily: FontNameDefaultBody,
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 40.0),
                  ),
                  Image(
                    image: AssetImage('assets/images/tick-loop.gif'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    child: GestureDetector(
                      child: CustomGradientButton("Voltar para home", "/home"),
                    ),
                    padding: const EdgeInsets.only(bottom: 15.0, top: 0.0),
                  ),
                  ProgressBar(1.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
