import 'package:flutter/material.dart';

import 'answer_widget.dart';
import 'bible_quote_widget.dart';

class DayQuestion extends StatefulWidget {
  final String _title;
  final List<dynamic> _questions;
  final String _memoryVerse;

  DayQuestion(this._title, this._questions, [this._memoryVerse]);

  @override
  _DayQuestionState createState() => _DayQuestionState();
}

class _DayQuestionState extends State<DayQuestion> {
  @override
  Widget build(BuildContext context) {
    var content = List<Widget>();
    content.add(
      Text(
        widget._title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );

    if (widget._memoryVerse != null) {
      content.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Text(widget._memoryVerse),
        ),
      );
    }

    widget._questions.forEach((question) {
      content.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Text(question['questionText']),
        ),
      );

      var quotes = List<Widget>();
      question['quotes'].forEach((quote) {
        quotes.add(BibleQuote(quote['book'], quote['verse']));
      });

      content.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: quotes.toList(),
          ),
        ),
      );

      content.add(Answer(question['id']));
    });

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: content.toList(),
    );
  }
}
