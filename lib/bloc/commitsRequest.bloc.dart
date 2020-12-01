import 'dart:convert';
import 'auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommitsRequest {
  static Future<Map<String, int>> getCommits(
      {@required String repository, @required String owner}) async {
    String userToken = await AuthService.readData();
    userToken = userToken.replaceAll(RegExp('"'), '');

    ///This map return the github username as a Key and the total
    ///of commits as value
    Map<String, int> userCommitsMap = {};
    final String githubApi =
        "https://git-breakdown-mobile.web.app/commits?owner=$owner&repository=$repository&token=$userToken";

    http.Client client = http.Client();
    var response = await client.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      for(var user in parsed){
        if(user is List) break;

       
          String username = user['name'];
          int userCommits = user['commits'];
          userCommitsMap[username] = userCommits;
       
      }
    } catch (err) {
      return null;
    }

    return userCommitsMap;
  }
}
