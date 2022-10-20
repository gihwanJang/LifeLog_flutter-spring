import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../home.dart';
import '../model/user.dart';
import '../sign_in.dart';
import '../signed_background.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  static final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          margin: const EdgeInsets.only(bottom: 60),
          color: Color.fromARGB(150, 255, 219, 181),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 30),
          child: Text(
            Home.user.name + " 님",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              _logout();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(300, 80),
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text(
              "로그아웃",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ],
    );
  }

  _logout() {
    storage.delete(key: 'login');
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => Scaffold(
            body: Stack(
          children: [Background(), SignIn()],
        )),
      ),
    );
  }
}
