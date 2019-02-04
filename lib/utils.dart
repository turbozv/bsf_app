import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> httpGetJson(String url) async {
  final response = await http.get(url);

  if (response.statusCode != 200) {
    return null;
  }

  return json.decode(response.body);
}

Future<String> httpGet(String url) async {
  final response = await http.get(url);

  if (response.statusCode != 200) {
    return null;
  }

  return response.body;
}

Future<dynamic> assetsGetJson(String path) async {
  print('--- Parse json from: $path');
  var jsonStr = await rootBundle.loadString(path);
  return jsonDecode(jsonStr);
}

Future<dynamic> getBooklist(String lang) async {
  var books = await assetsGetJson('assets/lessons/books.json');
  return books[lang]['booklist'];
}

Future<dynamic> getLesson(String lang, String id) async {
  var items = await assetsGetJson('assets/lessons/$lang.json');
  return items['LESSON/$id?lang=$lang'];
}

Future<dynamic> getBible(String version, String book, String verses) async {
  var bookIds = await assetsGetJson('assets/json/bookid.json');
  var bookId = 0;
  for (var item in bookIds) {
    if (item['name'] == book) {
      bookId = item['id'];
      break;
    }
  }

  if (bookId == 0) {
    return "Error";
  }

  var chapterFrom = 0;
  var verseFrom = 0;
  var chapterTo = 0;
  var verseTo = 0;

  var strs = splitString(verses, [':', '-']);
  if (strs.length == 1) {
    // parse chapter: 1
    chapterFrom = int.tryParse(strs[0]);
    verseFrom = 1;
    chapterTo = chapterFrom;
    verseTo = 999;
  } else if (strs.length == 3 && strs[1] == '-') {
    // parse chapter: 1-2
    chapterFrom = int.tryParse(strs[0]);
    verseFrom = 1;
    chapterTo = int.tryParse(strs[2]);
    verseTo = 999;
  } else if (strs.length == 3 && strs[1] == ':') {
    // parse chapter: 1:33
    chapterFrom = int.tryParse(strs[0]);
    verseFrom = int.tryParse(strs[2]);
    chapterTo = chapterFrom;
    verseTo = verseFrom;
  } else if (strs.length == 5 && strs[1] == ':' && strs[3] == '-') {
    // parse chapter: 1:1-3
    chapterFrom = int.tryParse(strs[0]);
    verseFrom = int.tryParse(strs[2]);
    chapterTo = chapterFrom;
    verseTo = int.tryParse(strs[4]);
  } else if (strs.length == 7 &&
      strs[1] == ':' &&
      strs[3] == '-' &&
      strs[5] == ':') {
    // parse chapter: 1:1-2:10
    chapterFrom = int.tryParse(strs[0]);
    verseFrom = int.tryParse(strs[2]);
    chapterTo = int.tryParse(strs[4]);
    verseTo = int.tryParse(strs[6]);
  } else {
    return "Error";
  }

  // print('getBible($version, $book, $verse) => $chapterFrom:$verseFrom-$chapterTo:$verseTo');
  var bible = await assetsGetJson('assets/bibles/$version.json');
  var chapterId = chapterFrom;
  var verseId = verseFrom;
  var result = '';
  while (chapterId * 1000 + verseId <= chapterTo * 1000 + verseTo) {
    var id = bookId * 1000000 + chapterId * 1000 + verseId;
    var text = bible[id.toString()];
    if (text == null) {
      text = '';
    }
    // Chinese bible has some empty verse
    if (bible[id.toString()] == null && bible[(id + 1).toString()] == null) {
      chapterId++;
      verseId = 1;
    } else {
      result += '$chapterId:$verseId $text\n';
      // result.push({ verse: `${chapter}:${verse}`, text: fromNetwork ? text : getVerseText(text) });
      verseId++;
    }
  }

  return result;
}

splitString(String str, List<String> delimiters) {
  var result = List<String>();
  var start = 0;
  for (var i = 0; i < str.length; i++) {
    if (delimiters.indexOf(str[i]) != -1) {
      result.add(str.substring(start, i));
      result.add(str[i]);
      start = i + 1;
    }
  }

  if (start != str.length) {
    result.add(str.substring(start));
  }

  return result;
}
