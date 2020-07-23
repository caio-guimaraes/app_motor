import 'package:flutter/material.dart';

import '../style.dart';
import 'audio_list_page.dart';
import 'audio_list_page.dart';

class SearchAudio extends StatelessWidget {
  var audioListPage = new AudioListPage(
    type: "big",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text(
              "Lista de áudios:",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: PrimaryBlue2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: FontNameDefaultBody,
              ),
            ),
            padding: const EdgeInsets.all(16),
          ),
          Expanded(child: audioListPage),
        ],
      ),
    );
  }
}
