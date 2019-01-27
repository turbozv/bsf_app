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
  var _booksJson = Map<String, dynamic>();
  var _bookList = List<dynamic>();

  @override
  void initState() {
    super.initState();

    if (_booksJson.keys.length == 0) {
      parseJsonFromAssets('assets/json/books.json').then((books) {
        var items = List<String>();
        var lessons = List<String>();
        for (var year in books['chs']['booklist']) {
          lessons.add(year['title']);
          for (var week in year['lessons']) {
            items.add(week['id'] + ' ' + week['name']);
          }
        }

        setState(() {
          _booksJson = books;
          _bookList = _booksJson['chs']['booklist'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _bookList.length,
        itemBuilder: (context, index) {
          var list = List<Widget>();
          for (var item in _bookList[index]['lessons']) {
            var data = item['name'].split(' ');
            list.add(new Container(
                margin: const EdgeInsets.fromLTRB(15, 2, 5, 2),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                    title: Text('${data[1]}'),
                    subtitle: Text('${data[2]} ${data[0]}'),
                    trailing: Image.asset(
                      'assets/images/Materials.On.png',
                      width: 34,
                      height: 34,
                    ))));
          }
          return ExpansionTile(
            title: Text(_bookList[index]['title']),
            children: list.toList(),
          );
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //       itemCount: _items.length,
  //       itemBuilder: (context, index) {
  //         var data = _items[index].split(' ');
  //         return ListTile(
  //           title: Text('${data[2]}'),
  //           subtitle: Text('${data[3]} ${data[1]}'),
  //         );
  //       });
  // }
}
