import 'dart:convert';
import 'package:gbdmobile/Models/githubLoginRequest.dart';
import 'package:gbdmobile/Models/githubLoginResponse.dart';
import 'package:gbdmobile/secret_keys.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<auth.User> loginWithGitHub(String code) async {
    final http.Response response = await http.post(
      "https://github.com/login/oauth/access_token",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        GithubLoginRequest(
            clientId: CLIENT_ID, clientSecret: CLIENT_SECRET, code: code),
      ),
    );

    GithubLoginResponse loginResponse = GithubLoginResponse.fromJson(
      json.decode(response.body),
    );

    final auth.AuthCredential credential =
        auth.GithubAuthProvider.credential(loginResponse.accessToken);

    final auth.UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final auth.User user = userCredential.user;
    return user;
  }
}
