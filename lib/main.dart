import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth;

  @override
  void initState() {
    _auth = Auth();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FlatButton(
                    onPressed: () => _auth.signInWithGihub(),
                    child: Container(
                      
                      child: Text('Login with Github'),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.network(
                      'https://img.icons8.com/fluent/48/000000/github.png'),
                )
              ],
            )),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
