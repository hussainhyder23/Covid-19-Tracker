import 'dart:convert';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:myc19_app/pages/country_page.dart';
import 'package:myc19_app/widgets/info_widget.dart';
import 'package:myc19_app/widgets/most_affected_countries.dart';
import './widgets/world_wide_widget.dart';
import './datasource.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Map worldData;
fetchWorldWideData()async{
  http.Response response=await http.get('https://corona.lmao.ninja/all');
  setState(() {
    worldData=json.decode(response.body);
  });
}

List countryData;
fetchCountryData()async{
  http.Response response=await http.get('https://corona.lmao.ninja/countries?sort=cases');
  setState(() {
    countryData=json.decode(response.body); 
  });
}
@override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight),onPressed:(){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          } ,)
        ],
        title: Text('COVID-19 TRACKER',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              height: 100,
              color: Theme.of(context).brightness==Brightness.light?Colors.orange[100]:Colors.black87,
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(

              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Worldwide',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CountryPage()
                      ));
                    },
                                      child: Container(
                      decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      
                      padding: EdgeInsets.all(10),
                      child: Text('Regional',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.white),)),
                  ),
                ],
              ),
            ),
            worldData==null?CircularProgressIndicator(): WorldWideWidget(worldData: worldData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('Most Affected Countries',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
            ),
            SizedBox( height: 10,),
            countryData==null?Container(): MostAffectedWidget(countryData: countryData,),
            InfoWidget(),
            SizedBox(height: 20,),
            Center(child: Text('WE ARE TOGETHER IN THIS FIGHT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),)),
            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}

