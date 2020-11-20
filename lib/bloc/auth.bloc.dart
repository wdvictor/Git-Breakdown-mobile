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

  static bool githubAuth({@required BuildContext context}) {
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

  ///Essa função vai ser chamada no login para ver se o usuário já está autenticado,
  ///caso sim, ele redirecionada para o profile (gente muda de arquivo depois)
  static Future<void> verifyLoggedUser({@required BuildContext context}) async {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      print('(SYS) user is not null\n\n');

      /*LoggedUser.user = GbdUser(
        clientToken:
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );*/
    }
    /*AuthService.readData().then((data) {
        json.decode(data);
    });*/
  }

  //TODO: extrair essas 3 funções para um arquivo apropriado
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    print("${directory.path}/data.json");
    return File("${directory.path}/data.json");
  }

  static Future<File> saveData({@required token}) async {
    String data = json.encode(token);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  static Future<String> readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

}
