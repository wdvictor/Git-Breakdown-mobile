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

    try {
      pullRequestMap["total"] = parsed["open"] + parsed["closed"];
      pullRequestMap["open"] = parsed["open"];
      pullRequestMap["closed"] = parsed["closed"];
      pullRequestMap["refused"] = parsed["refused"];
      pullRequestMap["merged"] = parsed["merged"];
      if (parsed["refused_percent"] == null) {
        pullRequestMap["refusedPercent"] = 0.0;
      } else {
        try {
          pullRequestMap["refusedPercent"] = double.tryParse(
            parsed["refused_percent"].toString().substring(0, 4),
          );
        } catch (err) {
          pullRequestMap["refusedPercent"] = parsed["refused_percent"];
          pullRequestMap["refusedPercent"] =
              pullRequestMap["refusedPercent"].toDouble();
        }
      }

      double mergedPercent;

      if (pullRequestMap["total"] != 0) {
        mergedPercent =
            (pullRequestMap["merged"] / pullRequestMap["total"]) * 100;
      } else {
        mergedPercent = 0;
      }

      pullRequestMap["mergedPercent"] = mergedPercent;
    } catch (err) {
      print(
        '(SYS) error:' + err.toString(),
      );
      return null;
    }

    return pullRequestMap;
  }
}
