import 'package:covid_tracker/widgets/reuseable_row.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image;
  String name;
  int? totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
  DetailScreen({required this.image,required this.name,required this.totalCases,required this.totalDeaths,required this.todayRecovered,required this.active,required this.critical,required this.totalRecovered,required this.test});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${widget.name}"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
Stack(
  alignment: Alignment.topCenter,
  children: [
    Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
          child: Card(
            child:Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .06,),
                ReuseableRow(title: 'Cases', value: '${widget.totalCases}'),
                ReuseableRow(title: 'Total Deaths', value: '${widget.totalDeaths}'),
                ReuseableRow(title: 'Total Recovered', value: '${widget.totalRecovered}'),
                ReuseableRow(title: 'Active Cases', value: '${widget.active}'),
                ReuseableRow(title: 'Critical Cases', value: '${widget.critical}'),
                ReuseableRow(title: 'Today Recovered', value: '${widget.totalRecovered}'),
                ReuseableRow(title: 'Tests conducted', value: '${widget.test}'),


              ],
            ),
          ),
    ),
    CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage("${widget.image}"),
    ),
  ],
),
            ],
          ),
        ),
      ),
    );
  }
}
