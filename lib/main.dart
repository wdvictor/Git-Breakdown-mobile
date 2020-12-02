import 'package:flutter/material.dart';
import 'package:gbdmobile/routeGenerator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gbdmobile/ui/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.indigo
    ),
    home: LoginPage(),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
