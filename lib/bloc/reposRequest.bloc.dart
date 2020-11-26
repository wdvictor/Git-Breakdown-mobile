import 'dart:convert';

import 'package:http/http.dart' as http;

import 'LoggedUser.dart';

class ReposRequest {

  
  static Future<List<String>> getUserRepos() async {
    var githubApi =
        "https://api.github.com/users/${LoggedUser.user.userName}/repos";
    http.Client client = http.Client();
    var response = await client.get(githubApi);
    final parsed = json.decode(response.body);

    List<String> userRepos = [];
    try {
      parsed.forEach((value) {
        userRepos.add(value['name']);
      });
      return userRepos;
    } catch (err) {
      return null;
    }
  }
}
