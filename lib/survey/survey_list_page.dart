import 'package:app_motor/models/survey_model.dart';
import 'package:app_motor/style.dart';
import 'package:app_motor/survey/survey_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:app_motor/widgets/card_body.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SurveyListPage extends StatefulWidget {
  SurveyListPage({Key key}) : super(key: key);

  @override
  _SurveyListPageState createState() => _SurveyListPageState();
}

class _SurveyListPageState extends State<SurveyListPage> {
  List<Survey> _surveys = List<Survey>();

  Future<List<Survey>> fetchSurvey() async {
    var url = "https://appmotorbackend.herokuapp.com/api/survey";
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token 15fa534faf921067f69b1086a63af9aeb1613e4b"
      },
    );
    var listSurveys = List<Survey>();
    if (response.statusCode == 200) {
      var surveyDecode = utf8.decode(response.bodyBytes);
      var surveysJson = jsonDecode(surveyDecode);
      print('response: ${response.body}');
      print(surveysJson);
      for (var surveyJson in surveysJson) {
        var survey = Survey.fromJson(surveyJson);
        var str = survey.createdDate.substring(0, 10);
        var arr = str.split('-');
        str = arr[2] + "-" + arr[1] + "-" + arr[0];
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
        _surveys.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 45.0),
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
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
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Seja bem-vindo de volta!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: FontNameDefaultTitle,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            child: Text(
              "Últimas vistorias:",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: PrimaryBlue1,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                fontFamily: FontNameDefaultBody,
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 20, bottom: 15),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: CardBody(
                            _surveys[index].local, _surveys[index].createdDate),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SurveyDetailPage(survey: _surveys[index]),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: _surveys.length,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            child: Text(
              "Últimos áudios:",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: PrimaryBlue2,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                fontFamily: FontNameDefaultBody,
              ),
            ),
            padding: const EdgeInsets.only(top: 40, left: 20, bottom: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: CardBody(
                            _surveys[index].local, _surveys[index].createdDate),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SurveyDetailPage(survey: _surveys[index]),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: _surveys.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
