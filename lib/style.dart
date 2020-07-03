import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;

const String FontNameDefaultTitle = 'Vollkorn';
const String FontNameDefaultBody = 'Raleway';

const Color PrimaryBlue1 = Color(0xFF11105F);
const Color PrimaryBlue2 = Color(0xFF32318C);
const Color PrimaryBlue3 = Color(0xFF5958B7);

const Color SecondaryBlue1 = Color(0xFFA4F9C3);
const Color SecondaryBlue2 = Color(0xFFBDFBD4);
const Color SecondaryBlue3 = Color(0xFFEDFFF4);

const Color PrimaryRed1 = Color(0xFFF33030);
const Color PrimaryRed2 = Color(0xFFFF4A4A);
const Color PrimaryRed3 = Color(0xFFFF6B6B);

const AppBarTextStyle = TextStyle(
  fontFamily: FontNameDefaultTitle,
  fontWeight: FontWeight.w800,
  fontSize: MediumTextSize,
  color: PrimaryBlue1,
);

const TitleTextStyle = TextStyle(
  fontFamily: FontNameDefaultTitle,
  fontWeight: FontWeight.w600,
  fontSize: LargeTextSize,
  color: PrimaryRed1,
);

const Body1TextStyle = TextStyle(
  fontFamily: FontNameDefaultBody,
  fontWeight: FontWeight.w800,
  fontSize: BodyTextSize,
  color: Colors.black,
);
