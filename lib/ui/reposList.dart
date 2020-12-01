import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/LoggedUser.dart';
import 'package:gbdmobile/bloc/commitsRequest.bloc.dart';


class ReposList extends StatefulWidget {
  final List<String> reposList;
  ReposList({@required this.reposList});

  @override
  _ReposList createState() => _ReposList();
}

class _ReposList extends State<ReposList> {

  
 
  @override
  Widget build(BuildContext context) {
    CommitsRequest.getCommits(repository: 'flutter', owner: 'flutter');
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Image.network(LoggedUser.user.photoUrl),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.reposList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.reposList[index]),
            );
          },
        ),
      ),
    );
  }
}
