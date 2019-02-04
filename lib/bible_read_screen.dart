import 'package:flutter/material.dart';

import 'utils.dart';

class BibleRead extends StatefulWidget {
  final String _book;
  final String _verse;

  BibleRead(this._book, this._verse);

  @override
  _BibleReadState createState() => _BibleReadState();
}

class _BibleReadState extends State<BibleRead> {
  bool _loaded = false;
  String _content = "Loading";

  loadAsync() async {
    var content = await getBible('niv2011', widget._book, widget._verse);

    setState(() {
      _content = content;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget._book + widget._verse),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Text(
          _content,
          style: TextStyle(
            height: 1.25,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
