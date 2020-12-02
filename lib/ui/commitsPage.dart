import 'package:flutter/material.dart';
import 'package:gbdmobile/bloc/commits.dart';
import 'package:gbdmobile/bloc/commitsRequest.bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class CommitsPage extends StatefulWidget {
  @override
  _CommitsPageState createState() => _CommitsPageState();
}

class _CommitsPageState extends State<CommitsPage> {
  ///Return Red to bad status, blue to medium status, and green to
  ///good status based on user percent
  MaterialColor getColor({@required num avarage, @required num value}) {
    if (value <= avarage) {
      return Colors.red;
    } else if (value >= (avarage - avarage * 0.4) &&
        value < avarage + avarage * 0.6) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
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
                            color: Colors.indigo,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          'Commits',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
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
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
                                    child: Center(
                                      child: Text(
                                          snapshot.data['total']['contributors']
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
                    flex: 10,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 1,
                            centerSpaceRadius: 0,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sections: [
                              for (var users in snapshot.data.entries)
                                if (users.key != 'total')
                                  PieChartSectionData(
                                    color: getColor(
                                        value: users.value['commits'],
                                        avarage: snapshot.data['total']
                                                ['avarageCommits']
                                            .toDouble()),
                                    titlePositionPercentageOffset: 0.8,
                                    value: users.value['commits'].toDouble(),
                                    title: users.key.toString() +
                                        '\n' +
                                        ((users.value['commitsPercent']) * 100)
                                            .truncate()
                                            .toString() +
                                        '%',
                                    radius: MediaQuery.of(context).size.width *
                                        0.45,
                                    titleStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('Below average'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('In average'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.green,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text('Above average'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
