import 'package:app_motor/style.dart';
import 'package:app_motor/vehicle/vehicle_bloc.dart';
import 'package:app_motor/survey/survey_register_page.dart';
import 'package:app_motor/vehicle/vehicle_list_page.dart';
import 'package:app_motor/widgets/big_card_body.dart';
import 'package:app_motor/widgets/medium_card_body.dart';
import 'package:app_motor/widgets/curved_navigation.dart';
import 'package:app_motor/vehicle/vehicle_register_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SearchVehicle extends StatefulWidget {
  @override
  _SearchVehicleState createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> {
  var bloc = new VehicleBloc();
  var response;
  var is_visible = 0;
  // is_visible == 0 (default), is_visible == 1 (no results), is_visible == 2 (found results)
  var _modelo = "";
  var _placa = "";
  bool _progressVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          controller: bloc.plateCtrl,
          decoration: InputDecoration(
            labelText: "Pesquisar placa:",
            labelStyle: AppBarStyle,
          ),
          style: AppBarStyle,
          validator: (String value) {
            if (value.length != 7)
              return "Placa inválida.";
            else if (value == null)
              return "Por favor, insira uma placa.";
            else
              return null;
          },
        ),
        backgroundColor: PrimaryBlue3,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                setState(() {
                  is_visible = 3;
                });
                var plate = bloc.plateCtrl.text;
                var response;
                await bloc.getVehiclesByPlate(plate).then(
                      (value) => {
                        response = value,
                        setState(
                          () {
                            response == null ? is_visible = 1 : is_visible = 2;
                          },
                        ),
                      },
                    );
                if (response == null) {
                  final message = SnackBar(
                    backgroundColor: Colors.white,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Não foi possivel encontrar um veiculo com a placa $plate. Tente novamente",
                        style: TextStyle(
                            color: PrimaryRed2,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontNameDefaultBody),
                      ),
                    ),
                  );
                  Scaffold.of(context).showSnackBar(message);
                  setState(
                    () {
                      is_visible = 1;
                    },
                  );
                } else {
                  final message = SnackBar(
                    backgroundColor: Colors.white,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Carro encontrado:",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontNameDefaultBody),
                      ),
                    ),
                  );
                  Scaffold.of(context).showSnackBar(message);
                  setState(() {
                    is_visible = 2;
                    _placa = response["plate"];
                    _modelo = response["model"];
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: bodyContent(is_visible, _placa, _modelo),
      // if (is_visible = 2) ContentWithResults
      // else if (visible = 1) ContentWithoutResults
      // else if (visible = 3) CircularProgressIndicator
      // else SizedBox
    );
  }
}

class ContentWithResults extends StatelessWidget {
  var _modeloBody = '';
  var _placaBody = '';

  ContentWithResults(this._modeloBody, this._placaBody);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          child: Text(
            "Lista de placas dos veículos:",
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
        GestureDetector(
          child: BigCardBody(_placaBody, _modeloBody),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveyPage(plate: _placaBody),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ContentWithoutResults extends StatelessWidget {
  var _placaBody = '';

  ContentWithoutResults(this._placaBody);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.not_interested,
                    size: 24,
                    color: Gray5,
                  ),
                ),
                TextSpan(
                  text: " Sem resultados",
                  style: TextStyle(
                      color: Gray5,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontNameDefaultBody,
                      fontSize: 22),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            color: Gray5,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 35.0, right: 35.0),
              child: Text(
                "Cadastrar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontFamily: FontNameDefaultBody,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleRegisterPage(plate: _placaBody),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150.0,
        width: 150.0,
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Gray5),
            strokeWidth: 10.0),
      ),
    );
  }
}

class PresetContent extends StatelessWidget {
  var vehicleListPage = new VehicleListPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text(
              "Lista de placas dos veículos:",
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
          Expanded(child: vehicleListPage),
        ],
      ),
    );
  }
}

bodyContent(is_visible, _placa, _modelo) {
  switch (is_visible) {
    case 1:
      return ContentWithoutResults(_placa);
      break;
    case 2:
      return ContentWithResults(_modelo, _placa);
      break;
    case 3:
      return ContentLoading();
      break;
    default:
      return PresetContent();
      break;
  }
}
