import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';
import 'package:gbdmobile/bloc/reposRequest.bloc.dart';
import 'package:gbdmobile/routeGenerator.dart';

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
  String _selectedRepository;

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

  _signOut() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
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
        title: _selectedRepository == null?
          Text("Git BreakDown") : Text(_selectedRepository),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: _selectedRepository,
                        hint: Text("Selecione um repositório"),
                        icon: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_drop_down)
                        ),
                        iconSize: 24,
                        isExpanded: true,
                        isDense: true,
                        //elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedRepository = newValue;
                          });
                        },
                        items: _userRepos
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Sair'),
                        onTap: _signOut,
                      ),
                    ],
                  )
                )
              )
            )
          ],
        ),
      ),
      body: Container(),
    );
  }

}

