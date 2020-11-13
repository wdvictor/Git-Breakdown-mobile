import 'package:flutter/material.dart';

class GithubLoginResponse {
  final String accessToken;
  final String tokenType;
  final String scope;

  GithubLoginResponse(
      {@required this.accessToken,
      @required this.tokenType,
      @required this.scope});
      
  factory GithubLoginResponse.fromJson(Map<String, dynamic> json) =>
      GithubLoginResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        scope: json["scope"],
      );
}
