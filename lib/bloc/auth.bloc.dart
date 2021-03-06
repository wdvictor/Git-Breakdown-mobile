import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/routeGenerator.dart';
import 'package:gbdmobile/secret_keys.dart' as SecretKey;
import 'package:github_auth/github_auth.dart';
import 'package:path_provider/path_provider.dart';

class AuthService {


  ///This function create the login url and send a request to github to
  ///authenticate the user. Then will be create the file of the user to hold the token, and the firebase user
  ///in case of non-existent user.
  static Future<bool> githubAuth({@required BuildContext context}) async {
    try {
      final githubAuth = GithubAuth(
        clientId: SecretKey.CLIENT_ID,
        clientSecret: SecretKey.CLIENT_SECRET,
        callbackUrl:
            'https://git-breakdown-mobile.firebaseapp.com/__/auth/handler',
      );

      githubAuth.login(context).then((value) {
        createFirebaseUser(token: value.token);
        Navigator.pushReplacementNamed(context, RouteGenerator.HOME_ROUTE);
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> createFirebaseUser({@required token}) async {
    try {
      final auth.AuthCredential credential =
          auth.GithubAuthProvider.credential(token);

      final auth.UserCredential userCredential =
          await auth.FirebaseAuth.instance.signInWithCredential(credential);
      
      
      LoggedUser.user = GbdUser(
          userName: userCredential.additionalUserInfo.username,
          clientToken: token,
          photoUrl: userCredential.user.photoURL,
          email: userCredential.user.email,
          displayName: userCredential.user.displayName);
      await saveData(user: LoggedUser.user);

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<File> _getFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
    } catch (err) {
      return null;
    }
  }


  ///This function take the token and save into a file to use later.
  static Future<File> saveData({@required user}) async {
    String data = json.encode(LoggedUser.user.toJson());

    final file = await _getFile();
    return file.writeAsString(data);
  }


  ///This functions get's the file and return it as a string. Returns null in
  ///case if non-existent file.
  static Future<String> readData() async {
    try {
      final file = await _getFile();
      
      if(await file.exists())
        return file.readAsString();
      else
        return null;
      
    } catch (e) {
      return null;
    }
  }
}
