import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  var _items = List<String>();

  @override
  void initState() {
    super.initState();

    if (_items.length == 0) {
      parseJsonFromAssets('assets/json/books.json').then((dmap) {
        var items = List<String>();
        for (var year in dmap['chs']['booklist']) {
          items.add(year['title']);
          for (var week in year['lessons']) {
            items.add(week['id'] + ': ' + week['name']);
          }
        }

        setState(() {
          _items = items;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_items[index]}'),
          );
        });
  }
}
