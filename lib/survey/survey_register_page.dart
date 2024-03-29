import 'dart:convert';

import 'package:app_motor/audio/recording_audio_page.dart';
import 'package:app_motor/home/home_page.dart';
import 'package:app_motor/style.dart';
import 'package:app_motor/survey/survey_bloc.dart';
import 'package:app_motor/vehicle/vehicle_bloc.dart';
import 'package:app_motor/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class SurveyPage extends StatefulWidget {
  final String plate;

  const SurveyPage({Key key, this.plate}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  var vehicle = new VehicleBloc();
  var survey = new SurveyBloc();
  var _local;
  final _formKey = GlobalKey<FormState>();
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vistoria do veículo " + widget.plate,
          style: AppBarStyle,
        ),
        backgroundColor: PrimaryBlue3,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Text(
                      "Registre sua vistoria:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Gray3,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontNameDefaultBody,
                      ),
                    ),
                    padding: const EdgeInsets.only(bottom: 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: TextFormField(
                      controller: survey.vehicleCtrl,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      decoration: new InputDecoration(
                        labelText: "Placa (${widget.plate.toString()})",
                        hintText: widget.plate,
                        hintStyle: TextStyle(
                          color: Gray3,
                          fontFamily: FontNameDefaultBody,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: TextStyle(
                            color: Gray3,
                            fontFamily: FontNameDefaultBody,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide:
                        //       BorderSide(color: PrimaryBlue1, width: 1.2),
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Gray4, width: 1.5),
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Gray4,
                        ),
                      ),
                      // onEditingComplete: () async {
                      //   var result = await survey.getVehicles(survey.vehicleCtrl.text);
                      //   survey.idVehicle = result["id"];
                      //   print(result);
                      //   print(result["id"]);
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: _local,
                      hint: Text("Selecione o local"),
                      items: <String>[
                        'Ponto de Venda',
                        'Céu aberto',
                        'Residência cliente',
                        'Pátio de leilão',
                        'Pátio de locadora',
                        'Pátio de vistoria',
                        'Revenda autorizada',
                        'Lojista'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String category) {
                        setState(
                          () {
                            _local = category;
                            controller:
                            survey.localCtrl = _local;
                            print("Selected: ${_local}");
                          },
                        );
                      },
                      decoration: new InputDecoration(
                        hintStyle: TextStyle(
                          color: PrimaryBlue1,
                          fontFamily: FontNameDefaultBody,
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: TextStyle(
                            color: Gray3,
                            fontFamily: FontNameDefaultBody,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: PrimaryBlue1, width: 1.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   // borderSide: BorderSide(color: Gray3, width: 1.5),
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Escolha um local';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Builder(
                      builder: (context) => FlatButton(
                        color: PrimaryBlue2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Continuar ",
                                  style: TextStyle(
                                      color: Gray6,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontNameDefaultBody,
                                      fontSize: 18),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: Gray6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var resultVehicle =
                                await survey.getVehicles(widget.plate);
                            print(resultVehicle);
                            print(resultVehicle["id"]);
                            var surveyBody = {};
                            //surveyBody["idVehicle"] = resultVehicle["id"];
                            String idVehicle = resultVehicle["id"].toString();
                            surveyBody["local"] = survey.localCtrl;
                            //print("idVehicle" + surveyBody["idVehicle"]);
                            print("local" + surveyBody["local"]);
                            // final String plateCtrl = bloc.plateCtrl.text;
                            // final String yearCtrl = bloc.yearCtrl;
                            // final String modelCtrl = bloc.modelCtrl.text;
                            // final String mileageCtrl = bloc.mileageCtrl.toString();
                            // final String fuelCtrl = bloc.fuelCtrl;
                            // final String turboCtrl = bloc.turboCtrl.toString();
                            // print("placa" + plateCtrl);
                            // print("ano" + yearCtrl);
                            // print("model" + modelCtrl);
                            // print("KM" + mileageCtrl.toString());
                            // print("fuel" + fuelCtrl);
                            // print("turbo" + turboCtrl.toString());
                            var body = jsonEncode(surveyBody);
                            print("body" + body.toString());
                            var result =
                                await survey.postSurvey(body, idVehicle);
                            print(result.body);
                            print(result.statusCode);
                            if (result.statusCode == 201) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecordingAudioPage(plate: widget.plate),
                                ),
                              );
                            } else {
                              final message = SnackBar(
                                  content: Text("Erro de autenticação"));
                              Scaffold.of(context).showSnackBar(message);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  ProgressBar(0.35),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
