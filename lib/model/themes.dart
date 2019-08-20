import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData redTheme() {
    return new ThemeData(
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primaryColor: Colors.red,
//    primaryColorDark: const Color(0xFF0050a0),
      primaryColorLight: Colors.redAccent,
      indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
      accentColor: Colors.grey,
      cardColor: Colors.white60,
      toggleableActiveColor: Colors.black,
      fontFamily: 'Tomica',
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
    );
  }

  static ThemeData yellowTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.yellow,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.yellowAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.grey,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData blueTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.blue,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.blueAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.grey,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData indigoTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.indigo,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.indigoAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.grey,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData greenTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.green,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.greenAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.grey,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData blackTheme() {
    return new ThemeData(
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primaryColor: Colors.black,
//    primaryColorDark: const Color(0xFF0050a0),
      primaryColorLight: Colors.grey,
      focusColor: Colors.amber,
//    toggleableActiveColor: const Color(0xFF6997DF),
      accentColor: Colors.grey,
      cardColor: Colors.white60,
      fontFamily: 'Tomica',
      toggleableActiveColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
    );
  }
}
