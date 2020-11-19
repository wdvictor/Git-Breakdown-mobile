import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/widgets.dart';
import 'package:gbdmobile/secret_keys.dart' as SecretKey;
import 'package:github_auth/github_auth.dart';

class AuthService {
  static bool githubAuth({@required BuildContext context}) {
    try {
      final githubAuth = GithubAuth(
        clientId: SecretKey.CLIENT_ID,
        clientSecret: SecretKey.CLIENT_SECRET,
        callbackUrl:
            'https://git-breakdown-mobile.firebaseapp.com/__/auth/handler',
      );

      githubAuth.login(context).then((value) {
        print('(SYS) token' + value.token.toString());
        createFirebaseUser(token: value.token);
      });
      return true;
    } catch (error) {
      print('(SYS) error' + error.toString());
      return false;
    }
  }

  static Future<bool> createFirebaseUser({@required token}) async {
    try {
      final auth.AuthCredential credential =
          auth.GithubAuthProvider.credential(token);

      await auth.FirebaseAuth.instance.signInWithCredential(credential);

      return true;
    } catch (error) {
      print(
        '(SYS) error : ' + error.toString(),
      );
      return false;
    }
  }
}
