import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum ThemeType {
  light,
  dark,
  system,
}

const BOX_NAME_THEME = "BOX_NAME_THEME";
const KEY_THEME = "KEY_THEME";

class ThemeBloc extends ChangeNotifier {
  String currentTheme = ThemeType.system.name;

  var box = Hive.box<String>(BOX_NAME_THEME);

  ThemeBloc() {
    currentTheme = box.get(KEY_THEME) ?? "system";
  }

  ThemeMode getCurrentTheme() {
    if (currentTheme == ThemeType.light.name) {
      return ThemeMode.light;
    } else if (currentTheme == ThemeType.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeTheme() {
    if (currentTheme == ThemeType.light.name) {
      currentTheme = ThemeType.dark.name;
    } else {
      currentTheme = ThemeType.light.name;
    }

    box.put(KEY_THEME, currentTheme);
    debugPrint('change theme success $currentTheme');
    notifyListeners();
  }
}

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
);

ThemeData dartTheme = ThemeData(
  primaryColor: Colors.black,
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);
