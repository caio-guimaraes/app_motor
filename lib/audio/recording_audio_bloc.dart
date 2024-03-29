import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecordingAudioBloc {
  final String url = "https://appmotorbackend.herokuapp.com/api/audio/";
  String audioCtrl;

  Future<http.Response> registerAudio(String survey_id, var body) async {
    var prefs = await SharedPreferences.getInstance();
    var texto = prefs.getString('token');
    var response = await http.post(
      url + "survey/" + survey_id + "/",
      headers: {"Content-Type": "application/json", "Accept": "application/json", "Authorization": "Token 15fa534faf921067f69b1086a63af9aeb1613e4b"},
      body: body,
    );
    return response;
  }

  Future<Map> getAudio(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var texto = prefs.getString('token');
    var res = await http.get(
      url+key,
      headers: {"Content-Type": "application/json", "Accept": "application/json", "Authorization": "Token 15fa534faf921067f69b1086a63af9aeb1613e4b "},
    );
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    }
  }
}
