import 'package:covid_tracker/Model/world_stats_model.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/coutries_list_screen.dart';
import 'package:covid_tracker/widgets/reuseable_row.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  _WorldStatsState createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            FutureBuilder(
              future: statsServices.fetchWorldStatsRecords(),
              builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recoverd": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            chartValueStyle: TextStyle(fontSize: 15,color: Colors.black)
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions:
                          const LegendOptions(legendPosition: LegendPosition.left,legendTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: const [Colors.blue, Colors.green, Colors.red],

                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: 'Total', value: '${snapshot.data?.cases}'),
                                ReuseableRow(title: 'Deaths', value: '${snapshot.data?.deaths}'),
                                ReuseableRow(title: 'Recovered', value: '${snapshot.data?.recovered}'),
                                ReuseableRow(title: 'Active', value: '${snapshot.data?.active}'),
                                ReuseableRow(title: 'Critical', value: '${snapshot.data?.critical}'),
                                ReuseableRow(title: 'Today Deaths', value: '${snapshot.data?.todayDeaths}'),
                                ReuseableRow(title: 'Today Recovered', value: '${snapshot.data?.todayRecovered}'),

                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                            },
                            child: Text(
                              "Track Countries",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
