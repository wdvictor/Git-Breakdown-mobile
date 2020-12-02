import 'package:flutter/material.dart';
import 'package:gbdmobile/ui/homePage.dart';
import 'package:gbdmobile/ui/login.dart';

class RouteGenerator{
  static const String ROOT_ROUTE = "/";
  static const String LOGIN_ROUTE = "/login";
  static const String HOME_ROUTE = "/home";
  static const String SETTINGS_ROUTE = "/settings";

  static Route<dynamic> generateRoute(RouteSettings settings){
    //final args = settings.arguments;

    switch(settings.name){
      case ROOT_ROUTE:
        return MaterialPageRoute(
            builder: (_) => LoginPage()
        );
      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => LoginPage()
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      default:
        _routeError();
    }
    return null;
  }

  static Route<dynamic> _routeError(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Text("Tela não encontrada!"),
          );
        }
    );
  }
}