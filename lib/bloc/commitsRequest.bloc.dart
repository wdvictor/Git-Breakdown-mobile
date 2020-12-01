import 'dart:convert';
import 'package:gbdmobile/bloc/commits.dart';
import 'package:gbdmobile/ui/commitsPage.dart';

import 'auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommitsRequest {
  static Future<Map<String, Map<String, num>>> getCommits(
      {@required String repository, @required String owner}) async {

      return commitsMap;
    Map<String, Map<String, num>> userCommitsMap = {};
    int totalCommits = 0;
    String userToken = await AuthService.readData();
    userToken = userToken.replaceAll(RegExp('"'), '');
    final String githubApi =
        "https://git-breakdown-mobile.web.app/commits?owner=$owner&repository=$repository&token=$userToken";

    var response = await http.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      for(var user in parsed){
        if(user is List) break;
        totalCommits += user['commits'];
        userCommitsMap[user['name']] = {};
        userCommitsMap[user['name']]["commits"] = user['commits'];
      }
    } catch (err) {
      return null;
    }

    for(var user in userCommitsMap.keys)
      userCommitsMap[user]["commitsPercent"] = userCommitsMap[user]["commits"]/totalCommits;

    int totalContributors = userCommitsMap.keys.length;
    userCommitsMap["total"] = {};
    userCommitsMap["total"]["commits"] = totalCommits;
    userCommitsMap["total"]["contributors"] = totalContributors;

    return userCommitsMap;
  }
}
