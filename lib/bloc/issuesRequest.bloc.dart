import 'dart:convert';
import 'LoggedUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IssuesRequest {
  static Future<Map<String, num>> getIssues(
      {@required String repository, @required String owner}) async {
    String token = LoggedUser.user.clientToken;

    Map<String, num> issuesMap = {};
    final String githubApi =
        "https://git-breakdown-mobile.web.app/issues?owner=$owner&repository=$repository&token=$token";

    http.Client client = http.Client();
    var response = await client.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      issuesMap["open"] = parsed["open"];
      issuesMap["closed"] = parsed["closed"];
      issuesMap["openPercent"] = parsed["openPercent"];
      issuesMap["closedPercent"] = parsed["closedPercent"];

      if (issuesMap["openPercent"] == null) issuesMap["openPercent"] = 0.0;

      if (issuesMap["closedPercent"] == null) issuesMap["closedPercent"] = 0.0;
    } catch (err) {
      return null;
    }

    return issuesMap;
  }
}
