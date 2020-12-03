import 'dart:convert';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PRRequest {
  static Future<Map<String, num>> getPRs(
      {@required String repository, @required String owner}) async {
    Map<String, num> pullRequestMap = {};
    String token = LoggedUser.user.clientToken;
    final String githubApi =
        "https://git-breakdown-mobile.web.app/pullRequest?owner=$owner&repository=$repository&token=$token";

    var response = await http.get(githubApi);
    final parsed = json.decode(response.body);
    print(parsed);
    try {
      pullRequestMap["total"] = parsed["open"] + parsed["closed"];
      pullRequestMap["open"] = parsed["open"];
      pullRequestMap["closed"] = parsed["closed"];
      pullRequestMap["refused"] = parsed["refused"];
      pullRequestMap["merged"] = parsed["merged"];
      if(parsed["refused_percent"] == null) {
        pullRequestMap["refusedPercent"] = 0;
      }else {
        pullRequestMap["refusedPercent"] = double.tryParse(
          parsed["refused_percent"].toString().substring(0, 4),
        );
      }
      double mergedPercent = (pullRequestMap["merged"] / pullRequestMap["total"]) * 100;
      pullRequestMap["mergedPercent"] = mergedPercent;
      //double.tryParse(((parsed["merged"] / pullRequestMap["total"]) * 100).toString().substring(0, 5));
          
    } catch (err) {
      print(
        '(SYS) error:' + err.toString(),
      );
      return null;
    }
    print(pullRequestMap);
    return pullRequestMap;
  }
}
