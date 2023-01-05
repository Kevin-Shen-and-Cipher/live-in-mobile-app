import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:live_in/page/search_menu/data.dart';
import 'package:live_in/page/search_menu/left_search_menu.dart';
import 'package:live_in/page/search_menu/righ_search_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'search_menu/searchPage_DataDetails.dart';
import 'dart:convert';

var Getrightdata=[];
var Getleftdata=[];

class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    //print("initState");
  }
  int drawerIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(147, 197, 253, 1),
        title: Text(
          'LiveIn',
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.house),
              onPressed: () {
                //Scaffold.of(context).openDrawer();
                drawerIndex=1;
                Getrightdata=[];
                Navigator.push(context,MaterialPageRoute(
                    builder: (BuildContext contest){
                  return left_search_menu();
                })).then((_) => setState(() {}));
              },
            );
          },
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.work),
                onPressed: () {
                  //Scaffold.of(context).openEndDrawer();
                  Getleftdata=[];
                  drawerIndex=2;
                  Navigator.push(context,MaterialPageRoute(
                      builder: (BuildContext contest){
                        return righ_search_menu();
                      })).then((_) => setState(() {}));
                },
              );
            },
          )
        ],
      ),
      // drawer: left_search_menu(),
      // endDrawer: righ_search_menu(),
      body: Container(
        child: Stack(
          children: [

            //Text(dotenv.env['API_URL'] ?? 'API_URL not found'),

            if(Getleftdata.isEmpty&&Getrightdata.isEmpty)
              Center(
                child: Image.asset('assets/turtle/turtle5.png'),
              ),
            if(drawerIndex==1)
              buildApartment(),
            if(drawerIndex==2)
              buildJob(),
          ],
        )
      ),
    );
  }
}
Widget buildJob() => ListView.builder(

  itemCount: Getrightdata.length,
  itemBuilder: (context, index) {
    final job = Getrightdata[index];

    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
        child: Column( //用Column讓兩排文字可以垂直排列
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0), //兩排文字間距用透明的box隔開
              Text(job.getName(),style:TextStyle(fontSize: 21),),
              ListTile(
                subtitle: Text(job.getDistrict()["city"]["name"]+" "+job.getDistrict()["name"],style:TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                title: Text(job.getAddress(),style:TextStyle(fontSize: 19)),
              ),
              Row(
                children: [
                  Text("職位："+job.getJob_position()["name"],style:TextStyle(fontSize: 14),),
                  SizedBox(width: 15,),
                  Text("工作時段："+job.getWorking_hour()["name"],style:TextStyle(fontSize: 14),),
                  SizedBox(width: 15,),
                  Text("需求年資："+job.getTenure().toString(),style:TextStyle(fontSize: 14),),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: ()async{
                      //Uri url = Uri.parse(job.getUrl());
                      if (!await launchUrl(Uri.parse(job.getUrl()))) {
                        throw 'Could not launch ${Uri.parse(job.getUrl())}';
                      }
                    },
                    child: Text('前往查看'),
                  ),
                  SizedBox(width: 120,),
                  Text("薪水:"+job.getSalary().toString(),style:TextStyle(color: Colors.redAccent,fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              )
            ]
        ),
      ),
    );
  },
);

Widget buildApartment() => ListView.builder(

      itemCount: Getleftdata.length,
      itemBuilder: (context, index) {
        final apartment = Getleftdata[index];

        return Card(
          child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Column( //用Column讓兩排文字可以垂直排列
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0), //兩排文字間距用透明的box隔開
              Text(apartment.getTitle(),style:TextStyle(fontSize: 21),),
              ListTile(
                subtitle: Text(apartment.getDistrict()["city"]["name"]+" "+apartment.getDistrict()["name"],style:TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                title: Text(apartment.getAddress(),style:TextStyle(fontSize: 19)),
              ),
              Row(
                children: [
                  Text("格局:："+apartment.getRoomType()["name"],style:TextStyle(fontSize: 14),),
                  SizedBox(width: 15,),
                  Text("房子類型："+apartment.getApartmentType()["name"],style:TextStyle(fontSize: 14),),
                  SizedBox(width: 15,),
                  Text("租賃類型："+apartment.getRentType()["name"],style:TextStyle(fontSize: 14),),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    onPrimary: Colors.white, // foreground
                  ),
                    onPressed: ()async{
                    //Uri url = Uri.parse(apartment.getUrl());
                    if (!await launchUrl(Uri.parse(apartment.getUrl()))) {
                      throw 'Could not launch ${Uri.parse(apartment.getUrl())})';
                    }
                    },
                  child: Text('前往查看'),
                ),
                  SizedBox(width: 150,),
                  Text("租金:"+apartment.getPrice().toString(),style:TextStyle(color: Colors.redAccent,fontSize: 20,fontWeight: FontWeight.bold)),
                ],
              )
            ]
          ),
          ),
        );
      },
    );
