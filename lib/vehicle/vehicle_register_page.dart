import 'dart:convert';
import 'package:app_motor/survey/survey_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:app_motor/vehicle/search_vehicle_page.dart';
import 'package:app_motor/vehicle/vehicle_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style.dart';
import '../style.dart';
import '../style.dart';
import '../style.dart';
import '../survey/survey_complete.dart';

enum SingingCharacter { sim, nao }

class VehicleRegisterPage extends StatefulWidget {
  final String plate;
  const VehicleRegisterPage({Key key, this.plate}) : super(key: key);
  @override
  _VehicleRegisterPageState createState() => _VehicleRegisterPageState();
}

class _VehicleRegisterPageState extends State<VehicleRegisterPage> {
  var texto = 'olá';
  var bloc = new VehicleBloc();
  var _fuel;
  String _date = "Não selecionado";
  final formattedDate = new DateFormat('yyyy');
  SingingCharacter _character = SingingCharacter.nao;
  int _value = 10;
  final _formKey = GlobalKey<FormState>();

  getToken() async {
    var prefs = await SharedPreferences.getInstance();
    texto = prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de um novo veículo",
          style: AppBarStyle,
        ),
        backgroundColor: PrimaryBlue3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: bloc.plateCtrl,
                  decoration: InputDecoration(
                      labelText: "Placa", hintText: widget.plate),
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty)
                      return "Escolha a placa";
                    else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  controller: bloc.modelCtrl,
                  decoration: InputDecoration(
                    labelText: "Modelo",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty)
                      return "Escolha um modelo";
                    else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  controller: bloc.yearCtrl,
                  decoration: InputDecoration(
                    labelText: "Ano ",
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Gray4,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  validator: (String value) {
                    if (value.isEmpty)
                      return "Escolha o ano";
                    else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: DropdownButtonFormField<String>(
                  value: _fuel,
                  hint: Text("Selecione o combustível"),
                  items: <String>['Gasolina', 'Álcool', 'Gás', 'Flex', 'Diesel']
                      .map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String category) {
                    setState(
                      () {
                        _fuel = category;
                        controller:
                        bloc.fuelCtrl = _fuel;
                        print("Selected: ${_fuel}");
                      },
                    );
                  },
                  validator: (String value) {
                    if (value == null)
                      return "Escolha um tipo de combustivel";
                    else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Turbo', style: SubitleCard),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      activeColor: PrimaryBlue2,
                      value: SingingCharacter.sim,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          bloc.turboCtrl = true;
                        });
                      },
                    ),
                    Text('Sim', style: SubitleCard),
                    Radio(
                      activeColor: PrimaryBlue2,
                      value: SingingCharacter.nao,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          bloc.turboCtrl = false;
                        });
                      },
                    ),
                    Text(
                      'Não',
                      style: SubitleCard,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Quilometragem', style: SubitleCard),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red[700],
                    inactiveTrackColor: Colors.red[100],
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: Colors.redAccent,
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    activeTickMarkColor: Colors.red[700],
                    inactiveTickMarkColor: Colors.red[100],
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.redAccent,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    value: _value.toDouble(),
                    min: 10,
                    max: 200,
                    divisions: 19,
                    label: '$_value' + 'mil km',
                    onChanged: (value) {
                      setState(
                        () {
                          _value = value.round();
                          controller:
                          bloc.mileageCtrl = _value;
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                                    text: "Criar ",
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
                              var vehicle = {};
                              vehicle["plate"] = bloc.plateCtrl.text;
                              vehicle["year"] = bloc.yearCtrl.text;
                              vehicle["model"] = bloc.modelCtrl.text;
                              vehicle["mileage"] = bloc.mileageCtrl;
                              vehicle["fuelType"] = bloc.fuelCtrl;
                              vehicle["turbo"] = bloc.turboCtrl;
                              var body = jsonEncode(vehicle);
                              print("body" + body.toString());
                              var result = await bloc.registerVehicle(body);
                              print(result.body);
                              print(result.statusCode);
                              String texto =
                                  "Veículo " + vehicle["plate"] + " ok";
                              if (result.statusCode == 201) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurveyComplete(texto,
                                        "Veículo registrado com sucesso!"),
                                  ),
                                );
                              } else {
                                final message =
                                    SnackBar(content: Text(result.body));
                                Scaffold.of(context).showSnackBar(message);
                              }
                            } else {
                              debugPrint("invalid data");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
