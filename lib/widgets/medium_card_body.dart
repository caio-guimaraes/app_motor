import 'package:flutter/material.dart';

import '../style.dart';

class MediumCardBody extends StatelessWidget {
  String title = '';
  String subtitle = '';

  MediumCardBody(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Container(
        width: 130.0,
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TitleCard,
                ),
                Text(
                  subtitle,
                  style: SubitleCard,
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
