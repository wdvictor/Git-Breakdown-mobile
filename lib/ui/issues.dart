import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IssuesData extends StatefulWidget {
  @override
  _IssuesDataState createState() => _IssuesDataState();
}

class _IssuesDataState extends State<IssuesData> {

  Future <Map> _getData() async {
    http.Response response = await http.get("https://git-breakdown-mobile.web.app/issues?owner=&repository=&token=");

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    _getData().then((map){
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
