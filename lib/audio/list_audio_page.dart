import 'package:app_motor/models/audio_model.dart';
import 'package:app_motor/style.dart';
import 'package:flutter/material.dart';
import 'package:app_motor/widgets/card_body.dart';
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
    var url = "https://appmotorbackend.herokuapp.com/api/audio/survey/employee/1";
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token 15fa534faf921067f69b1086a63af9aeb1613e4b"
      },
    );
    var listSurveys = List<Audio>();
    if (response.statusCode == 200) {
      var surveyDecode = utf8.decode(response.bodyBytes);
      var surveysJson = jsonDecode(surveyDecode);
      print('response: ${response.body}');
      print(surveysJson);
      for (var surveyJson in surveysJson) {
        var survey = Audio.fromJson(surveyJson);
        var str=survey.createdDate.substring(0,10);
        var arr= str.split('-');
        str= arr[2]+ "-" + arr[1]+"-"+arr[0];
        survey.createdDate = str;
        listSurveys.add(survey);
      }
    }
    return listSurveys;
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
        return CardBody(
            _audios[index].survey_id.toString(), _audios[index].key
        );
      },
      itemCount: _audios.length,
    );
  }
}
