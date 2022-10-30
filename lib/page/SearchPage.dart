import 'package:flutter/material.dart';
import 'package:live_in/page/search_menu/righ_search_menu.dart';
import 'search_menu/left_search_menu.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(147,197,253,1),
        title: Text('LiveIn',),
        centerTitle: true,
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: Icon(Icons.house),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },);
          },),
        actions: <Widget>[
          Builder(
            builder: (context){
              return IconButton(
                icon: Icon(Icons.work),
                onPressed: (){
                  Scaffold.of(context).openEndDrawer();
                },);
            },)
        ],
      ),
      drawer:left_search_menu(),

      endDrawer: righ_search_menu(),


    );
  }
}


