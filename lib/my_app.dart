import 'package:app_motor/home/home_page.dart';
import 'package:app_motor/vehicle/search_vehicle_page.dart';
import 'package:app_motor/vehicle/vehicle_list_page.dart';
import 'package:app_motor/style.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP-MOTOR',
      debugShowCheckedModeBanner: false,
      theme: _theme(),
      home: _introScreen(),
      routes: {
        "/home": (_) => new HomePage(),
        "/audios": (_) => new HomePage(),
        "/vehicles": (_) => new SearchVehicle(),
      },
    );
  }

  ThemeData _theme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(headline6: AppBarTextStyle),
      ),
      textTheme:
          TextTheme(headline6: TitleTextStyle, bodyText2: Body1TextStyle),
    );
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [PrimaryBlue3, SecondaryBlue1],
        ),
        navigateAfterSeconds: HomePage(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logoMotor.png'),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}
