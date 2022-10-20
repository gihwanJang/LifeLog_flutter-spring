import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import '../home.dart';
import '../model/log.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime _dateTime = DateTime.now();
  List<Log> _userLogs = [];
  String url = "http://52.79.56.116:3000/log";
  Map<String, double> _logMap = {
    "항목이": 1,
    "없습니다.": 1,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          color: const Color.fromARGB(200, 225, 230, 223),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    _setYesterday();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  child: Text(
                    _dateTime.year.toString() +
                        "년 " +
                        _dateTime.month.toString() +
                        "월 " +
                        _dateTime.day.toString() +
                        '일',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _setTomorrow();
                  },
                  icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
          child: const Text(
            "월간 로그",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          color: const Color.fromARGB(200, 225, 230, 223),
          child: SizedBox(
            height: 200,
            child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _detailLogText(index);
                          });
                    },
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: Text(_userLogs[index].datetime.year.toString() +
                          "년" +
                          _userLogs[index].datetime.month.toString() +
                          "월" +
                          _userLogs[index].datetime.day.toString() +
                          "일 " +
                          _userLogs[index].datetime.hour.toString() +
                          ":" +
                          _userLogs[index].datetime.minute.toString() +
                          "\n" +
                          _userLogs[index].title),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      height: 10,
                      color: Colors.green,
                    ),
                itemCount: _userLogs.length),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30, bottom: 5),
          alignment: Alignment.centerLeft,
          child: const Text(
            "월간 통계",
            style: TextStyle(fontSize: 18),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _detailStatistics();
                });
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            color: const Color.fromARGB(200, 225, 230, 223),
            child: PieChart(
              dataMap: _logMap,
              animationDuration: Duration(milliseconds: 800),
              centerText: _dateTime.month.toString() + "월 통계",
            ),
          ),
        )
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      initialDate: DateTime.now(),
      cancelText: 'Close',
    );
    if (pickedDate != null && pickedDate != _dateTime) {
      setState(() {
        _dateTime = pickedDate;
        _setMap();
      });
    }
  }

  _setYesterday() {
    setState(() {
      _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day - 1);
      _setMap();
    });
  }

  _setTomorrow() {
    setState(() {
      _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day + 1);
      _setMap();
    });
  }

  Future<List<Log>> _setLogList() async {
    DateTime endTime = DateTime(_dateTime.year, _dateTime.month + 1, 0);
    DateTime startTime = DateTime(_dateTime.year, _dateTime.month, 1);
    try {
      var res = await http.get(
        Uri.parse(url +
            "/" +
            Home.user.id.toString() +
            "/" +
            startTime.toString() +
            "/" +
            endTime.toString()),
        headers: {'Context-Type': 'application/json; charset=UTF-8'},
      );
      setState(() {
        _userLogs = (json.decode(utf8.decode(res.bodyBytes)) as List)
            .map((data) => Log.fromJson(data))
            .toList();
      });
      print(_userLogs.length);
    } catch (e) {
      print(e);
    }
    return _userLogs;
  }

  AlertDialog _detailLogText(index) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Log',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.green),
      ),
      content: Text(_userLogs[index].datetime.year.toString() +
          "년" +
          _userLogs[index].datetime.month.toString() +
          "월" +
          _userLogs[index].datetime.day.toString() +
          "일 " +
          _userLogs[index].datetime.hour.toString() +
          ":" +
          _userLogs[index].datetime.minute.toString() +
          "\n" +
          _userLogs[index].title +
          "\n" +
          _userLogs[index].context),
      actions: const [],
    );
  }

  AlertDialog _detailStatistics() {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Graph about time',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.green),
      ),
      content: Text(""),
      actions: const [],
    );
  }

  _setMap() async {
    await _setLogList();
    if (_userLogs.isEmpty) {
      setState(() {
        _logMap = {
          "항목이": 1,
          "없습니다.": 1,
        };
      });
      return;
    }

    Map<String, double> logmap = {};
    for (Log l in _userLogs) {
      if (logmap.containsKey(l.title))
        logmap[l.title] = logmap[l.title]! + 1;
      else
        logmap[l.title] = 1;
    }

    setState(() {
      _logMap = logmap;
    });
  }
}
