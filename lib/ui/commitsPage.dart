import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/commits.dart';
import 'package:gbdmobile/bloc/commitsRequest.bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class CommitsPage extends StatefulWidget {
  @override
  _CommitsPageState createState() => _CommitsPageState();
}

class _CommitsPageState extends State<CommitsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: CommitsRequest.getCommits(
              repository: '2019.2-Git-Breakdown', owner: 'fga-eps-mds'),
          builder:
              (context, AsyncSnapshot<Map<String, Map<String, num>>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            print(snapshot.data);
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('Commits'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
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
                                    decoration:
                                        BoxDecoration(color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total de commits:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    constraints: BoxConstraints.expand(),
                                    decoration:
                                        BoxDecoration(color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total de contribuidores',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
                                    child: Center(
                                      child: Text(
                                          snapshot.data['total']['commits']
                                              .toString(),
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
                                    decoration: BoxDecoration(
                                      color: Colors.grey
                                    ),
                                    child: Center(
                                      child: Text(
                                          snapshot.data['total']
                                                  ['totalContributors']
                                              .toString(),
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
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sections: [
                              for (var users in snapshot.data.entries)
                                if (users.key != 'total')
                                  PieChartSectionData(
                                    titlePositionPercentageOffset: 0.8,
                                    value: users.value['commits'].toDouble(),
                                    title: users.key.toString(),
                                    radius: MediaQuery.of(context).size.width *
                                        0.45,
                                    titleStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
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
