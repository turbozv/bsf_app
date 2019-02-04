import 'package:flutter/material.dart';

import 'bible_read_screen.dart';

class BibleQuote extends StatefulWidget {
  final String _book;
  final String _verse;

  BibleQuote(this._book, this._verse);

  @override
  _BibleQuoteState createState() => _BibleQuoteState();
}

class _BibleQuoteState extends State<BibleQuote> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BibleRead(widget._book, widget._verse),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
        margin: EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget._book + widget._verse,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
