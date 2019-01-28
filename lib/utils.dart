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

Future<Map<String, dynamic>> assetsGetJson(String path) async {
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
