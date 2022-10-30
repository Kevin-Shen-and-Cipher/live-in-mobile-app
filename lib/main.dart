import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button_plus/dropdown_plus.dart' as plus;


import 'package:live_in/page/infoPage.dart';
import 'page/HomePage.dart';
import 'page/SearchPage.dart';
//test
//testoop


void main()=>runApp(MaterialApp(title: 'app',
  home: new MainPage(),
));

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex=0;
  final screens=[
    const HomePage(),
    const SearchPage(),
    const infoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(147,197,253,1),//rgba(126, 214, 223,1.0)
        selectedItemColor: Colors.white,
        iconSize: 30,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index)=>setState(()=>currentIndex=index),
        items: const [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: 'Home',),
          BottomNavigationBarItem(
            icon:Icon(Icons.search),
            label: 'Search',),
          BottomNavigationBarItem(
            icon:Icon(Icons.density_medium),
            label: 'info',
          )],
      ),
    );}
}
//___________home__________


