import 'package:flutter/widgets.dart';
import 'package:gbdmobile/secret_keys.dart' as SecretKey;
import 'package:github_auth/github_auth.dart';

class AuthService {
  static bool githubAuth({@required BuildContext context}) {
    try {
      final auth = GithubAuth(
        clientId: SecretKey.CLIENT_ID,
        clientSecret: SecretKey.CLIENT_SECRET,
        callbackUrl: 'https://git-breakdown-mobile.firebaseapp.com/__/auth/handler',
      );

      
      auth.login(context).then((value) {
        print('(SYS) token' + value.token.toString());
      });
      return true;
    } catch (error) {
      print('(SYS) error' + error.toString());
      return false;
    }
  }
}
