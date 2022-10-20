import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelog/home.dart';
import 'package:lifelog/main.dart';
import 'package:lifelog/sign_up.dart';
import 'package:lifelog/signed_background.dart';
import 'package:http/http.dart' as http;

import 'model/user.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  User user = User(id: '', pw: '', name: '');

  String url = "http://52.79.56.116:3000/users";

  Future<User?> _read() async {
    try {
      final reader = await storage.read(key: 'login');
      if (reader?.isNotEmpty ?? false) {
        return User.fromJson(json.decode(reader!));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future _save(User saver) async {
    await storage.write(key: 'login', value: json.encode(saver.toJson()));
  }

  Future httpLogin() async {
    try {
      var res = await http.get(
        Uri.parse(url + "/" + user.id.toString()),
        headers: {'Context-Type': 'application/json'},
      );

      Map<String, dynamic> userMap = json.decode(utf8.decode(res.bodyBytes));
      User tmp = User.fromJson(userMap);
      if (user.id != "" && tmp.id == user.id) {
        if (tmp.pw == user.pw) {
          showToast2("로그인 완료");
          user = tmp;
          Home.user = tmp;
          _save(tmp);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Home()));
        } else {
          showToast("아이디/ 비밀번호가 틀렸습니다.1");
          tmp = User(id: '', pw: '', name: '');
        }
      } else {
        showToast("아이디/ 비밀번호가 틀렸습니다.2");
      }
    } catch (exception) {
      showToast("인터넷이 연결되지 않았습니다.");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final reader = await _read();
    String k = reader?.id ?? '';
    if (reader != null) print('출력입니다.' + k);
    if (reader != null) {
      Home.user = reader;
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        key: _formKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: const Text(
              "로그인",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                Container(
                  height: 150,
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
                          controller: TextEditingController(text: user.pw),
                          onChanged: (val) {
                            user.pw = val;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '비밀번호를 입력해주세요';
                            }
                            return "";
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(fontSize: 22),
                            border: InputBorder.none,
                            icon: Icon(Icons.lock),
                            hintText: "********",
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
                      httpLogin();
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
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, top: 24),
            child: TextButton(
              child: const Text(
                "회원가입",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffe98f60),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Stack(
                        children: [Background(), SignUp()],
                      )),
                    ));
              },
            ),
          )
        ]);
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
