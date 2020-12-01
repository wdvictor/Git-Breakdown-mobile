import 'dart:convert';
import 'auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PRRequest {
  static Future<Map<String, num>> getPRs(
      {@required String repository, @required String owner}) async {
    Map<String, num> pullRequestMap = {};
    String userToken = await AuthService.readData();
    userToken = userToken.replaceAll(RegExp('"'), '');

    final String githubApi =
        "https://git-breakdown-mobile.web.app/pullRequest?owner=$owner&repository=$repository&token=$userToken";

    var response = await http.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      pullRequestMap["total"] = parsed["open"] + parsed["closed"];
      pullRequestMap["open"] = parsed["open"];
      pullRequestMap["closed"] = parsed["closed"];
      pullRequestMap["refused"] = parsed["refused"];
      pullRequestMap["merged"] = parsed["merged"];
      pullRequestMap["refusedPercent"] = parsed["refused_percent"];
      pullRequestMap["mergedPercent"] = parsed["merged"]/pullRequestMap["total"];
    } catch (err) {
      return null;
    }

    return pullRequestMap;
  }
}
