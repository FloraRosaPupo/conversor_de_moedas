import 'package:flutter/material.dart';
import 'features/converter/presentation/home_page.dart';

void main() async {
  runApp(MaterialApp(
      home: Home(),
      //adicionando um tema
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          ))));
}
