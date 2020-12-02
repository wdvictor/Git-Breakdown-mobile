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
        backgroundColor: Colors.grey[300],
        body: FutureBuilder(
          future: BranchesRequest.getBranches(
              repository: '2019.2-Git-Breakdown', owner: 'fga-eps-mds'),
          builder: (context, AsyncSnapshot<Map<String, num>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1.1,
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
                    Expanded(
                      flex: 10,
                      child: Chart(
                        branchesData: snapshot.data,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ChartSubtitleWidget(),
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

class ChartSubtitleWidget extends StatelessWidget {
  const ChartSubtitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Below 40% of merged branches'),
                    ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Between 40% and 60% of merged branches'),
                    ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Above 60% of merged branches'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final Map<String, num> branchesData;
  const Chart({@required this.branchesData});

  MaterialColor getColor({@required num value}) {
    if (value <= 39)
      return Colors.red;
    else if (value > 39 && value <= 60)
      return Colors.blue;
    else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              PieChartSectionData(
                color: getColor(value: branchesData['percentage_merged']),
                titlePositionPercentageOffset: 0.5,
                value: branchesData['percentage_merged'],
                title: 'Merged Branches' +
                    ' ${branchesData['percentage_merged']}% ',
                radius: MediaQuery.of(context).size.width * 0.45,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                color: Colors.indigo,
                titlePositionPercentageOffset: 0.5,
                value: 100 - branchesData['percentage_merged'],
                title: '',
                radius: MediaQuery.of(context).size.width * 0.45,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
                        'Active branches',
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
                      child: Center(
                        child: Text(
                          'Percentage of branches merged',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
