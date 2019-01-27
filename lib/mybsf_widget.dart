import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Mybsf extends StatefulWidget {
  @override
  _MybsfState createState() => _MybsfState();
}

class _MybsfState extends State<Mybsf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(url: "http://mybsf.org");
  }
}
