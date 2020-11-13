import 'package:flutter/foundation.dart';

class GithubLoginRequest {
  final String clientId;
  final String clientSecret;
  final String code;

  GithubLoginRequest(
      {@required this.clientId,
      @required this.clientSecret,
      @required this.code});


  
  dynamic toJson() => {
        "client_id": clientId,
        "client_secrent": clientSecret,
        "code": code,
      };
}
