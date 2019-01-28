import 'package:bsf_app/day_question_widget.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class LessonScreen extends StatefulWidget {
  final String _id;
  final String _title;

  LessonScreen([this._id, this._title]);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool _loaded = false;
  String _memoryVerse;
  Map<String, dynamic> _dayQuestions;

  loadAsync() async {
    var content = await getLesson('chs', widget._id);

    setState(() {
      _memoryVerse = content['memoryVerse'];
      _dayQuestions = content['dayQuestions'];
      _loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    loadAsync();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text(widget._title),
          ),
          body: Center(child: Text('Loading')));
    }

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(widget._title),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: ['1', '2', '3', '4', '5', '6'].map((item) {
              return Tab(
                  child: Text(item,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)));
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            DayQuestion(_dayQuestions['one']['title'],
                _dayQuestions['one']['questions'], _memoryVerse),
            DayQuestion(_dayQuestions['two']['title'],
                _dayQuestions['two']['questions']),
            DayQuestion(_dayQuestions['three']['title'],
                _dayQuestions['three']['questions']),
            DayQuestion(_dayQuestions['four']['title'],
                _dayQuestions['four']['questions']),
            DayQuestion(_dayQuestions['five']['title'],
                _dayQuestions['five']['questions']),
            DayQuestion(_dayQuestions['six']['title'],
                _dayQuestions['six']['questions']),
          ],
        ),
      ),
    );
  }
}
