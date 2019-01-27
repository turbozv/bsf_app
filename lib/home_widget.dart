import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'lessons_widget.dart';
import 'mybsf_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  static List<String> _pageTitle = [
    'BSF Lesson',
    'MyBSF.org',
    'AudioBible',
    'My Settings'
  ];

  final List<Widget> _pages = [
    Lessons(),
    Mybsf(),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white)
  ];

  void onTabTapped(int index) {
    setState(() {
      print('currentIndex: $_currentIndex');
      _currentIndex = index;
    });
  }

  Image _getIcon(int index) {
    String path = 'assets/images/';
    switch (index) {
      case 0:
        path += 'Classes';
        break;
      case 1:
        path += 'mybsf';
        break;
      case 2:
        path += 'AudioBible';
        break;
      case 3:
        path += 'MySettings';
        break;
      default:
        return Image.asset('assets/images/icon.png', width: 30, height: 30);
    }

    path += '.' + (_currentIndex == index ? 'On' : 'Off') + '.png';
    return Image.asset(path, width: 30, height: 30);
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
              icon: _getIcon(0),
              title: Text(_pageTitle[0]),
            ),
            BottomNavigationBarItem(
              icon: _getIcon(1),
              title: Text(_pageTitle[1]),
            ),
            BottomNavigationBarItem(
              icon: _getIcon(2),
              title: Text(_pageTitle[2])),
            BottomNavigationBarItem(
              icon: _getIcon(3),
              title: Text(_pageTitle[3]))
          ],
        ),
      ),
    );
  }
}
