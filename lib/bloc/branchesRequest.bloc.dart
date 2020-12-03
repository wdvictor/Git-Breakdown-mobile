import 'dart:convert';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BranchesRequest {
  static Future<Map<String, num>> getBranches(
      {@required String repository, @required String owner}) async {

    Map<String, num> branchesMap = {};
    String token = LoggedUser.user.clientToken;
    final String githubApi =
        "https://git-breakdown-mobile.web.app/branches?owner=$owner&repository=$repository&token=$token";
    var response = await http.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      branchesMap["active_branches"] = parsed["active_branches"];
      branchesMap["percentage_merged"] = parsed["percentage_merged"];
    } catch (err) {
      return null;
    }
    return branchesMap;
  }
}
