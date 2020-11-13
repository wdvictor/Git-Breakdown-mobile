import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:uni_links/uni_links.dart';

import '../../secret_keys.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void OnCliclHithubLoginButton() async {
    print('1.');
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
      print('2.');
    } else {
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  final AuthService authService = AuthService();

  StreamSubscription _subs;

  @override
  void initState() {
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = _subs = getLinksStream().listen((String link) {
      print('3. $link');
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      print('5. link não é null');
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      authService.loginWithGitHub(code).then((firebaseUser) {
        print('6. ${firebaseUser.displayName}');
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: " + firebaseUser.displayName);
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
    print("5. link é null");
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    'Git Breakdown',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Container(
                  child: FlatButton(
                    onPressed: OnCliclHithubLoginButton,
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Login with Github',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                  'https://img.icons8.com/fluent/48/000000/github.png'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
