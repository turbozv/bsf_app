import 'package:flutter/material.dart';

import 'lesson_screen.dart';
import 'images.dart';
import 'utils.dart';

class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  var _bookList = List<dynamic>();

  void loadAsync() async {
    var bookList = await getBooklist('chs');
    setState(() {
      _bookList = bookList;
    });
  }

  @override
  void initState() {
    super.initState();

    loadAsync();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _bookList.length,
        itemBuilder: (context, index) {
          var list = List<Widget>();
          for (var item in _bookList[index]['lessons']) {
            var data = item['name'].split(' ');
            list.add(
              Container(
                margin: const EdgeInsets.fromLTRB(15, 2, 5, 2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonScreen(item['id'], data[1]),
                      ),
                    );
                  },
                  title: Text('${data[1]}'),
                  subtitle: Text('${data[2]} ${data[0]}'),
                  trailing: getIcon('Materials.On'),
                ),
              ),
            );
          }
          return ExpansionTile(
            title: Text(_bookList[index]['title']),
            children: list.toList(),
          );
        });
  }
}
