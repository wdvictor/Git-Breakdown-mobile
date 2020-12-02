import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/prRequest.bloc.dart';

class PrPage extends StatefulWidget {
  @override
  _PrPageState createState() => _PrPageState();
}

class _PrPageState extends State<PrPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: PRRequest.getPRs(
              repository: '2019.2-Git-Breakdown', owner: 'fga-eps-mds'),
          builder: (context, AsyncSnapshot<Map<String, num>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            print(snapshot.data);
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1.3,
                child: Column(
                  children: [
                    Expanded(
                      child: PageTitle(),
                    ),
                    Expanded(
                      flex: 6,
                      child: ContentTable(
                        prData: snapshot.data,
                      ),
                    ),
                    Expanded(flex: 10, child: Container()),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.indigo,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'Pull Request',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ContentTable extends StatelessWidget {
  final Map<String, num> prData;
  ContentTable({@required this.prData});

  final List<String> contentTableTitles = [
    'Total of Pull Requests',
    'Open Pull Request',
    'Closed Pull Request',
    'Refused Pull Requests',
    'Refused percent',
    'Merged Percent'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          ///Firts Collumn
          Expanded(
            child: Column(
              children: [
                for (var title in contentTableTitles)
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          ///Second Collumn
          Expanded(
            child: Column(
              children: [
                for (var data in prData.entries)
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Center(
                        child: Text(
                          data.value.runtimeType == double 
                          ? data.value.toString() + ' %'
                          : data.value.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
