import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/secret_keys.dart' as SecretKey;
import 'package:github_auth/github_auth.dart';
import 'package:path_provider/path_provider.dart';

class AuthService {
  static Future<bool> githubAuth({@required BuildContext context}) async {
    try {
      final githubAuth = GithubAuth(
        clientId: SecretKey.CLIENT_ID,
        clientSecret: SecretKey.CLIENT_SECRET,
        callbackUrl:
            'https://git-breakdown-mobile.firebaseapp.com/__/auth/handler',
      );

      githubAuth.login(context).then((value) {
        saveData(token: value.token);
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

      final auth.UserCredential userCredential =
          await auth.FirebaseAuth.instance.signInWithCredential(credential);
      
      
      LoggedUser.user = GbdUser(
          userName: userCredential.additionalUserInfo.username,
          clientToken: token,
          photoUrl: userCredential.user.photoURL,
          email: userCredential.user.email,
          displayName: userCredential.user.displayName);

      return true;
    } catch (error) {
      print(
        '(SYS) error : ' + error.toString(),
      );
      return false;
    }
  }


  //TODO: extrair essas 3 funções para um arquivo apropriado
  static Future<File> _getFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
    } catch (err) {
      print(
        '(SYS) error: ' + err.toString(),
      );
      return null;
    }
  }

  static Future<File> saveData({@required token}) async {
    String data = json.encode(token);

    final file = await _getFile();
    return file.writeAsString(data);
  }

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
