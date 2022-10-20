import 'dart:collection';
import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelog/home.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:http/http.dart' as http;

import '../model/log.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime now = DateTime.now();
  String title = "", logContext = "";

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: cirecleButton(context),
          )
        ]);
  }

  ElevatedButton cirecleButton(context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return logText();
              });
        },
        child: timeText(),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 255, 255, 255),
          onPrimary: const Color.fromARGB(255, 129, 129, 129),
          fixedSize: const Size(300, 300),
          side: const BorderSide(
              width: 12.0, color: Color.fromARGB(255, 255, 220, 252)),
          shape: const CircleBorder(),
        ));
  }

  TimerBuilder timeText() {
    return TimerBuilder.periodic(const Duration(seconds: 1),
        builder: (context) {
      return Text(
        formatDate(DateTime.now(), [hh, ':', nn, ':', ss]),
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 50,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      );
    });
  }

  AlertDialog logText() {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Log',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.green),
      ),
      content: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
            child: TextFormField(
              controller: TextEditingController(text: title),
              onChanged: (val) {
                title = val;
              },
              decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  border: InputBorder.none,
                  hintText: "제목",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
          ),
          TextFormField(
            controller: TextEditingController(text: logContext),
            onChanged: (val) {
              logContext = val;
            },
            decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
                hintText: "내용",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue),
                )),
            maxLines: 5,
            minLines: 1,
          )
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Center(child: Text("입력")),
          onPressed: () {
            _addLog();
          },
        )
      ],
    );
  }

  _addLog() async {
    Log log = Log(
        id: Home.user.id,
        title: title,
        context: logContext,
        datetime: DateTime.now());
    String url = "http://52.79.56.116:3000/log/addlog";
    if (log.title != "" && log.context != "") {
      try {
        var res = await http.post(Uri.parse(url),
            headers: {"Content-Type": 'application/json; charset=UTF-8'},
            body: json.encode({
              'id': log.id,
              'title': log.title,
              'context': log.context,
              'datetime': log.datetime.toIso8601String()
            }));
        showToast2("로그가 입력되었습니다!");
        Navigator.pop(context);
      } catch (e) {
        print(log.datetime);
        showToast("인터넷이 연결되지 않았습니다.");
      }
    } else {
      showToast("제목과 내용을 기입해 주세요");
    }
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
