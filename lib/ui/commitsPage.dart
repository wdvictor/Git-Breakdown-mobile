import 'package:flutter/material.dart';
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
            builder: (context, AsyncSnapshot<Map<String, int>> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              print(snapshot.data.keys);

              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          child: Text('Métricas de commits'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
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
                                  PieChartSectionData(
                                   titlePositionPercentageOffset: 0.8,
                                    value: users.value.toDouble(),
                                    title: users.key.toString(),
                                    radius: MediaQuery.of(context).size.width * 0.45,
                                    titleStyle: TextStyle(
                                      fontWeight: FontWeight.normal,

                                    )
                                    
                                  )
                              ])),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
