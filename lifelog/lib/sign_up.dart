import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lifelog/main.dart';

import 'model/user.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  User user = User(id: '', pw: '', name: '');
  String check = "";
  int emailCheck = -1;
  String url = "http://52.79.56.116:3000/user/sign-up";
  Future save() async {
    try {
      var res = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({'id': user.id, 'pw': user.pw, 'name': user.name}));
      if (res.body == "")
        showToast("이미 존재하는 아이디입니다.");
      else {
        showToast2("회원가입 완료!");
        Navigator.pop(context);
      }
    } catch (exception) {
      showToast("인터넷이 연결되지 않았습니다.");
      emailCheck = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 60),
          child: const Text(
            "회원가입",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.only(
                  right: 70,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextFormField(
                        controller: TextEditingController(text: user.id),
                        onChanged: (val) {
                          user.id = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '아이디를 입력해주세요';
                          }
                          return "";
                        },
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          border: InputBorder.none,
                          icon: Icon(Icons.account_circle_rounded),
                          hintText: "아이디",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextFormField(
                        controller: TextEditingController(text: user.name),
                        onChanged: (val) {
                          user.name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '이름을 입력해주세요';
                          }
                          return "";
                        },
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 22),
                          border: InputBorder.none,
                          icon: Icon(Icons.edit),
                          hintText: "이름",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextFormField(
                        controller: TextEditingController(text: user.pw),
                        onChanged: (val) {
                          user.pw = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '비밀번호를를 입력해주세요';
                          }
                          return "";
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 22),
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          hintText: "비밀번호",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextFormField(
                        controller: TextEditingController(text: check),
                        onChanged: (val) {
                          check = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '비밀번호를 재입력해주세요';
                          }
                          return "";
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 22),
                          border: InputBorder.none,
                          icon: Icon(Icons.check),
                          hintText: "비밀번호 확인",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (user.pw == check && user.id != "" && user.pw != "") {
                      save();
                    } else if (user.id == "") {
                      showToast("아이디를 입력해주세요");
                    } else if (user.pw == "") {
                      showToast("비밀번호를 입력해 주세요");
                    } else {
                      showToast("비밀번호가 일치하지 않습니다.");
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green[200]!.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xff1bccba),
                          Color(0xff22e2ab),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Color.fromARGB(255, 255, 90, 90),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  void showToast2(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Color.fromARGB(255, 46, 139, 252),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }
}
