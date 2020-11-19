import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/secret_keys.dart' as SecretKey;
import 'package:gbdmobile/ui/profile.dart';
import 'package:github_auth/github_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      //TODO: a gente precisa de uma forma de salvar o token do usuário. Depois q ele faz login
      // não encontrei uma forma de achar ele via currentUser. Aqui eu tentei salvar ele usando
      // no cloud_firestore, porem um erro está aconteçendo.
      print('creating user');
      CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
      usersRef.doc().set({'token' : token});

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

      
      // LoggedUser.user = GbdUser(
      //   clientToken: 
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Profile(),
      //   ),
      // );
    }
  }
}
