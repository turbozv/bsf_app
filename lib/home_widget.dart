import 'package:flutter/material.dart';
import 'placeholder_widget.dart';

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
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white)
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBars = [
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text(_pageTitle[0]),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.web),
      title: Text(_pageTitle[1]),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.audiotrack), title: Text(_pageTitle[2])),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), title: Text(_pageTitle[3]))
  ];

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
          items: _bottomNavigationBars,
        ),
      ),
    );
  }
}
