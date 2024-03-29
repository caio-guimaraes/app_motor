import 'dart:ffi';

import 'package:flutter/material.dart';
import '../style.dart';

class ProgressBar extends StatelessWidget {
  var progress = 0.0;

  ProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 10,
          child: LinearProgressIndicator(
            value: progress, // percent filled
            valueColor: AlwaysStoppedAnimation<Color>(SecondaryBlue1),
            backgroundColor: SecondaryBlue3,
          ),
        ),
      ),
    );
  }
}
