


import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Image.network(LoggedUser.user.photoUrl),
        ),
      ),
    );
  }
}