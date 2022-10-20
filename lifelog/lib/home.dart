import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifelog/home/clock_page.dart';
import 'package:lifelog/home/statistics_page.dart';
import 'package:timer_builder/timer_builder.dart';

import 'home/my_page.dart';
import 'main.dart';
import 'model/user.dart';
import 'sign_in.dart';
import 'signed_background.dart';

class Home extends StatefulWidget {
  static User user = User(id: "", pw: "", name: "");
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: Stack(
        children: [
          Background(),
          ClockPage(),
        ],
      ),
    ),
    StatisticsPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // Shifting
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: '타이머',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '통계',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '마이페이지',
            backgroundColor: Colors.orange,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
