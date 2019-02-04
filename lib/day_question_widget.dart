import 'package:flutter/material.dart';

import 'answer_widget.dart';
import 'bible_quote_widget.dart';

class DayQuestion extends StatefulWidget {
  final Map _dayQuestion;
  final String _memoryVerse;

  DayQuestion(this._dayQuestion, [this._memoryVerse]);

  @override
  _DayQuestionState createState() => _DayQuestionState();
}

class _DayQuestionState extends State<DayQuestion> {
  @override
  Widget build(BuildContext context) {
    var title = widget._dayQuestion['title'];
    var questions = widget._dayQuestion['questions'];
    var readVerse = widget._dayQuestion['readVerse'];

    var content = List<Widget>();
    content.add(
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (widget._memoryVerse != null) {
      content.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Text(
            '背诵经文：${widget._memoryVerse}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (readVerse != null) {
      content.add(this.getBibleQuotes(readVerse));
    }

    questions.forEach((question) {
      content.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Text(
            question['questionText'],
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );

      content.add(this.getBibleQuotes(question['quotes']));
      content.add(Answer(question['id']));
    });

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12.0),
      children: content.toList(),
    );
  }

  Widget getBibleQuotes(readVerse) {
    var quotes = List<Widget>();

    readVerse.forEach((quote) {
      quotes.add(BibleQuote(quote['book'], quote['verse']));
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Wrap(
        runSpacing: 3,
        children: quotes.toList(),
      ),
    );
  }
}
