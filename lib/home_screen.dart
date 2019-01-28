import 'package:flutter/material.dart';

import 'images.dart';

import 'lessons_widget.dart';
import 'mybsf_widget.dart';
import 'audio_bible_widget.dart';
import 'mysettings_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static List<String> _pageTitle = [
    'BSF Lesson',
    'MyBSF.org',
    'AudioBible',
    'My Settings'
  ];

  final List<Widget> _pages = [Lessons(), Mybsf(), AudioBible(), MySettings()];

  void onTabTapped(int index) {
    setState(() {
      print('currentIndex: $_currentIndex');
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(_pageTitle[_currentIndex]),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.amber,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: getTabIcon(0, _currentIndex == 0),
              title: Text(
                _pageTitle[0],
                style: TextStyle(fontSize: 12),
              ),
            ),
            BottomNavigationBarItem(
              icon: getTabIcon(1, _currentIndex == 1),
              title: Text(
                _pageTitle[1],
                style: TextStyle(fontSize: 12),
              ),
            ),
            BottomNavigationBarItem(
              icon: getTabIcon(2, _currentIndex == 2),
              title: Text(
                _pageTitle[2],
                style: TextStyle(fontSize: 12),
              ),
            ),
            BottomNavigationBarItem(
              icon: getTabIcon(3, _currentIndex == 3),
              title: Text(
                _pageTitle[3],
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
