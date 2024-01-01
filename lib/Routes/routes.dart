import 'package:flutter/material.dart';
import 'package:glassmorphism/HomePage/GetStarted.dart';
import 'package:glassmorphism/HomePage/HomePage.dart';
import 'package:glassmorphism/HomePage/PlaceDesc.dart';

abstract class Routes{
  static const home ='/';
  static const getStarted ='/getStart';
  static const placedesc ='/placeDesc';
}

Map<String, Widget Function(BuildContext)> appRoutes = {
    Routes.home:(context) => const HomePage(),
    Routes.getStarted:(context) => const GetStarted(),
    Routes.placedesc:(context) => PlaceDesc(),
};
