import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                  controller: searchController,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with a country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )),
            ),
            Expanded(
              child: FutureBuilder(
                  future: statsServices.fetchResultByCountry(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {

                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,int index){
                            String name=snapshot.data![index]['country'];
                       if(searchController.text.isEmpty){
                         return GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(

                               image:snapshot.data![index]['countryInfo']['flag'] ,
                               name:snapshot.data![index]['country'],
                               totalCases:snapshot.data![index]['cases'],
                               totalRecovered:snapshot.data![index]['recovered'],
                               totalDeaths:snapshot.data![index]['deaths'],
                               active:snapshot.data![index]['active'],
                               test:snapshot.data![index]['tests'],
                               todayRecovered:snapshot.data![index]['todayRecovered'],
                               critical:snapshot.data![index]['Critical']
                             )));
                           },
                           child: ListTile(
                             title : Text("${snapshot.data![index]['country']}"),
                             subtitle: Text("Cases: ${snapshot.data![index]['cases']}"),
                             leading: Image(
                               height: 50,
                               width: 50,
                               image: NetworkImage("${snapshot.data![index]['countryInfo']['flag']}"),
                             ),
                           ),
                         );
                       }
                       else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                         return GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(

                                 image:snapshot.data![index]['countryInfo']['flag'] ,
                                 name:snapshot.data![index]['country'],
                                 totalCases:snapshot.data![index]['cases'],
                                 totalRecovered:snapshot.data![index]['recovered'],
                                 totalDeaths:snapshot.data![index]['deaths'],
                                 active:snapshot.data![index]['active'],
                                 test:snapshot.data![index]['tests'],
                                 todayRecovered:snapshot.data![index]['todayRecovered'],
                                 critical:snapshot.data![index]['Critical']
                             )));
                           },
                           child: ListTile(
                             title : Text("${snapshot.data![index]['country']}"),
                             subtitle: Text("Cases: ${snapshot.data![index]['cases']}"),
                             leading: Image(
                               height: 50,
                               width: 50,
                               image: NetworkImage("${snapshot.data![index]['countryInfo']['flag']}"),
                             ),
                           ),
                         );
                       }
                       else{
                         return Container();
                       }
                      });
                    }
                  }

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
