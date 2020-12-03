import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbdmobile/Models/user.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/bloc/auth.bloc.dart';
import 'package:gbdmobile/bloc/reposRequest.bloc.dart';
import 'package:gbdmobile/routeGenerator.dart';
import 'package:gbdmobile/ui/branchesPage.dart';
import 'package:gbdmobile/ui/commitsPage.dart';
import 'package:gbdmobile/ui/issuesPage.dart';
import 'package:gbdmobile/ui/prPage.dart';

import 'InitialPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _metrics = ["home","Commits", "Issues", "Branches", "Pull Requests"];
  GbdUser _user = GbdUser(
      userName: "username",
      clientToken: "token",
      photoUrl: "",
      email: "Email do Usuário",
      displayName: "Nome do Usuário");
  List<String> _userRepos = [];
  ValueNotifier<String> selectedRepository = ValueNotifier('');
  String _selectedRepository;
  TabController _tabController;

  void getInitialData() async {
    if (LoggedUser.user == null) {
      await AuthService.readData().then(
        (value) {
          var data = json.decode(value);
          LoggedUser.user = GbdUser.fromJson(data);
          setState(
            () {
              _user = LoggedUser.user;
            },
          );
        },
      );
    }

    await ReposRequest.getUserRepos().then(
      (repos) {
        setState(
          () {
            _userRepos = repos;
            selectedRepository.value = repos.first;
            _selectedRepository = repos.first;
          },
        );
      },
    );
  }

  _signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
  }

  @override
  void initState() {
    super.initState();
    getInitialData();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedRepository == null
            ? Text("Git BreakDown")
            : Text(_selectedRepository),
        bottom: TabBar(
          isScrollable: true,
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: Platform.isIOS ? Colors.grey[400] : Colors.white,
          tabs: [
            for (final metric in _metrics)
              Tab(
                text: metric,
              )
          ],
        ),
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
                          child: Icon(Icons.arrow_drop_down)),
                      iconSize: 24,
                      isExpanded: true,
                      isDense: true,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 1,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(
                          () {
                            _selectedRepository = newValue;
                            selectedRepository.value = newValue;
                            Navigator.pop(context);
                          },
                        );
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
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Sair'),
                        onTap: _signOut,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: selectedRepository,
        builder: (context, repo, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              InitPage(),
              CommitsPage(repo),
              IssuesPage(repo),
              BranchesPage(repo),
              PrPage(repo)
            ],
          );
        },
      ),
    );
  }
}
