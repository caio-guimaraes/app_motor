import 'package:app_motor/models/audio_model.dart';
import 'package:app_motor/style.dart';
import 'package:app_motor/widgets/big_card_body.dart';
import 'package:flutter/material.dart';
// import 'package:app_motor/widgets/card_body.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AudioListPage extends StatefulWidget {
  AudioListPage({Key key}) : super(key: key);

  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  List<Audio> _audios = List<Audio>();

  Future<List<Audio>> fetchSurvey() async {
    var url = "https://appmotorbackend.herokuapp.com/api/audio/employee/35?limit=4";
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token 15fa534faf921067f69b1086a63af9aeb1613e4b"
      },
    );
    var listAudios = List<Audio>();
    if (response.statusCode == 200) {
      var audioDecode = utf8.decode(response.bodyBytes);
      var audiosJson = jsonDecode(audioDecode);
      print(audiosJson);
      for (var audioJson in audiosJson) {
        var audio = Audio.fromJson(audioJson);
        var str=audio.createdDate.substring(0,10);
        var arr= str.split('-');
        str= arr[2]+ "-" + arr[1]+"-"+arr[0];
        audio.createdDate = str;
        listAudios.add(audio);
      }
    }
    return listAudios;
  }

  @override
  void initState() {
    fetchSurvey().then((value) {
      setState(() {
        _audios.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 7, right: 7),
          child: BigCardBody('Audio ${_audios[index].id}', _audios[index].createdDate),
        );
      },
      itemCount: _audios.length,
    );
  }
}