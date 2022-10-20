import 'package:flutter/material.dart';
import 'package:lifelog/home.dart';
import 'package:lifelog/signed_background.dart';

import 'sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'life log',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Stack(
            children: [
              Background(),
              SignIn(),
            ],
          ),
        ));
  }
}
