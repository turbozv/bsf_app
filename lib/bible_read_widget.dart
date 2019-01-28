import 'package:flutter/material.dart';

class BibleRead extends StatefulWidget {
  final String _book;
  final String _verse;

  BibleRead(this._book, this._verse);

  @override
  _BibleReadState createState() => _BibleReadState();
}

class _BibleReadState extends State<BibleRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget._book + widget._verse),
      ),
      body: Text('TODO'),
    );
  }
}
