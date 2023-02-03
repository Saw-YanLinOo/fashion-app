import 'package:animation/blocs/theme_bloc.dart';
import 'package:animation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox<String>(BOX_NAME_THEME);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeBloc(),
      lazy: false,
      child: Consumer<ThemeBloc>(
        builder: (context, bloc, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: bloc.getCurrentTheme(),
            theme: lightTheme,
            darkTheme: dartTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
