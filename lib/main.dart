import 'package:example_max4/provider/tran_provider.dart';
import 'package:flutter/material.dart';
import './main_screen.dart';
import 'package:provider/provider.dart';
void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
//  );
  runApp(
      (
          ChangeNotifierProvider.value(
            value: TranProvider(),
        child: MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            button: TextStyle(color: Colors.white),
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(title: TextStyle(fontFamily: 'OpenSans', fontSize: 22)),
        ),
    ),
    title: "Personal Expenses",
    home: MyHome(),
  ),)
      ));
}

