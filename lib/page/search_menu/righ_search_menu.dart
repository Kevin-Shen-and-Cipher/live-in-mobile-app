import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

//work

class righ_search_menu extends StatefulWidget {
  const righ_search_menu({Key? key}) : super(key: key);

  @override
  State<righ_search_menu> createState() => _righ_search_menuState();
}

class _righ_search_menuState extends State<righ_search_menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child:Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                color: const Color.fromRGBO(126,214,223,1),
                height: 80,
                child: Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
              ),
              Container(
                color: Colors.redAccent,
                height: 150,
                child: Text("test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

