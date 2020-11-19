import 'package:flutter/material.dart';
import 'package:gbdmobile/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          child: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                return LoginPage();
              }),
        ),
      ),
    );
  }
}
