import 'package:flutter/material.dart';
import './datasource.dart';
import './myhomepage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        return ThemeData(
          fontFamily: 'RobotoCondensed',
          primaryColor: primaryBlack,
          brightness: brightness == Brightness.light
              ? Brightness.light
              : Brightness.dark,
          scaffoldBackgroundColor: brightness == Brightness.dark
              ? Colors.blueGrey[900]
              : Colors.white,
        );
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: MyHomePage(),
        );
      },
    );
  }
}
