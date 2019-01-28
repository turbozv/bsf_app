import 'package:flutter/material.dart';

Widget getIcon(String name, {double size = 30}) {
  return Image.asset('assets/images/$name.png', width: size, height: size);
}

Widget getTabIcon(int index, bool active) {
  String path;
  switch (index) {
    case 0:
      path = 'Classes';
      break;
    case 1:
      path = 'mybsf';
      break;
    case 2:
      path = 'AudioBible';
      break;
    case 3:
      path = 'MySettings';
      break;
    default:
      return getIcon('icon');
  }

  return getIcon(path + (active ? '.On' : '.Off'));
}
