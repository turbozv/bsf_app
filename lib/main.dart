import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'lesson_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBSF',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/lesson': (context) => LessonScreen(),
      }
    );
  }
}
