import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';
import 'package:gbdmobile/bloc/reposRequest.bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GbdUser _user = GbdUser(
      userName: "username",
      clientToken: "token",
      photoUrl: "",
      email: "Email do Usuário",
      displayName: "Nome do Usuário");
  List<String> _userRepos = [];

  void getInitialData() async{
    if(LoggedUser.user == null){
      await AuthService.readData().then(
              (value){
            var data = json.decode(value);
            LoggedUser.user = GbdUser.fromJson(data);
            setState(() {
              _user = LoggedUser.user;
            });
          }
      );
    }

    await ReposRequest.getUserRepos()
        .then((repos){
         setState(() {
           _userRepos = repos;
         });
    });
  }

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Git BreakDown"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(_user.displayName),
                accountEmail: Text(_user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_user.photoUrl),
                ),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }

}

