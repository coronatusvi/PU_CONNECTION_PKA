import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Pallete {
  //dark mode
  static const Color secondaryColor = Color.fromRGBO(29, 40, 58, 1);
  static const Color searchBarColor = Color.fromRGBO(32, 35, 39, 1);
  static const Color blueColor = Color.fromRGBO(29, 155, 240, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color blackColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color greyColor = Colors.grey;
  static const Color redColor = Color.fromRGBO(249, 25, 127, 1);
  static const Color noColor = Color.fromRGBO(255, 255, 255, 0);
  static const Color textformfieldColor = Color.fromRGBO(39, 54, 78, 1);
  static const Color subTextColor = Color.fromRGBO(131, 143, 160, 1);
  static const Color rhinoDark500 = Color.fromRGBO(44, 67, 100, 1);
  static const Color rhinoDark700 = Color.fromRGBO(29, 40, 58, 1);
  static const Color rhinoDark800 = Color.fromRGBO(20, 27, 39, 1);
  static const Color rhinoDark600 = Color.fromRGBO(39, 54, 78, 1);
  final titleColorProvider =
      StateProvider<Color>((ref) => Pallete.rhinoDark800);

  //Linear Gradient
  static const LinearGradient cardColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xffFFE072), Color(0xffFEBE19)],
  );

  //lightmode
  static const Color yellow500 = Color.fromRGBO(254, 240, 205, 1);
  static const Color yellow800 = Color.fromRGBO(214, 167, 48, 1);
}
