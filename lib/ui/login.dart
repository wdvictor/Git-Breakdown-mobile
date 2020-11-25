import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';
import 'package:gbdmobile/bloc/reposRequest.bloc.dart';
import 'package:gbdmobile/ui/reposList.dart';

import '../bloc/LoggedUser.dart';
import '../bloc/auth.bloc.dart';
import '../bloc/auth.bloc.dart';
import '../bloc/auth.bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService.readData().then(
      (fileString) {
        ///The [readData] function return null if no file exist.
        if (fileString != null) {
          AuthService.createFirebaseUser(
            token: fileString.replaceAll(RegExp('"'), ''),
          );
          ReposRequest.getUserRepos().then(
            (repos) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReposList(
                  reposList: repos,
                ),
              ),
            ),
          );
        }
      },
    );

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
                    onPressed: () async {
                      AuthService.githubAuth(context: context);
                    },
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
