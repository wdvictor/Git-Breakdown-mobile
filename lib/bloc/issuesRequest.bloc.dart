import 'dart:convert';
import 'auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IssuesRequest {
  static Future<Map<String, num>> getIssues(
      {@required String repository, @required String owner}) async {
    String userToken = await AuthService.readData();
    userToken = userToken.replaceAll(RegExp('"'), '');


    Map<String, num> issuesMap = {};
    final String githubApi =
        "https://git-breakdown-mobile.web.app/issues?owner=$owner&repository=$repository&token=$userToken";

    http.Client client = http.Client();
    var response = await client.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      issuesMap["open"] = parsed["open"];
      issuesMap["closed"] = parsed["closed"];
      issuesMap["openPercent"] = parsed["openPercent"];
      issuesMap["closedPercent"] = parsed["closedPercent"];
    } catch (err) {
      return null;
    }

    return issuesMap;
  }
}
