import 'dart:convert';
import 'auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BranchesRequest {
  static Future<Map<String, num>> getBranches(
      {@required String repository, @required String owner}) async {

    Map<String, num> branchesMap = {};
    String userToken = await AuthService.readData();

    userToken = userToken.replaceAll(RegExp('"'), '');
    final String githubApi =
        "https://git-breakdown-mobile.web.app/branches?owner=$owner&repository=$repository&token=$userToken";
    var response = await http.get(githubApi);
    final parsed = json.decode(response.body);

    try {
      branchesMap["active_branches"] = parsed["active_branches"];
      branchesMap["percentage_merged"] = parsed["percentage_merged"];
    } catch (err) {
      print('(SYS) error:' + err.toString());
      return null;
    }
    print(branchesMap);
    return branchesMap;
  }
}
