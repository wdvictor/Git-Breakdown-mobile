import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/branchesRequest.bloc.dart';

class BranchesPage extends StatefulWidget {
  @override
  _BranchesPageState createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: BranchesRequest.getBranches(
              repository: '2019.2-Git-Breakdown', owner: 'fga-eps-mds'),
          builder: (context, AsyncSnapshot<Map<String, num>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: PageTitle(),
                  ),
                  Expanded(
                    flex: 3,
                    child: ContentTable(
                      branchesData: snapshot.data,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContentTable extends StatelessWidget {
  final Map<String, num> branchesData;
  const ContentTable({@required this.branchesData});

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
                Expanded(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Branches ativas:',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                'Percentual de branches mergadas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                  '*The total of branches opened by the branches that is merged',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9
                                  ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          ///Second Collumn
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(branchesData['active_branches'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                          branchesData['percentage_merged'].toString() + '%',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          'Branches',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
