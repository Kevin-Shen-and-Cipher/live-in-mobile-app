import 'package:flutter/material.dart';

class infoPage extends StatelessWidget {
  const infoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LiveIn',),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(126,214,223,1),
        ),
        body: ListView(
          children: [

          ],
        )
    );

  }
}
