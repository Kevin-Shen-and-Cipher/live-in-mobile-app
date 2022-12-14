import 'package:flutter/material.dart';
import 'package:live_in/page/turtle.dart';
import 'package:url_launcher/url_launcher.dart';



class infoPage extends StatelessWidget {
  infoPage({Key? key}) : super(key: key);

  final Uri _url = Uri.parse('https://github.com/Kevin-Shen-and-Cipher');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LiveIn',),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(147,197,253,1),
        ),
        body: ListView(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () =>showAboutUs(context),
                child: Text('About us'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () =>Navigator.push(
                    context,MaterialPageRoute(builder: (context) => turtle())),
                child: Text('pet'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: ()=>showHelp(context),
                child: Text('Help'),
              ) ,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 60,left: 80,right: 80,bottom: 0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: _launchUrl,
                child: Text('Git Hub'),
              ) ,
            ),

          ],
        )
    );

  }
}




showAboutUs(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("?????????\n????????????????????????????????????\n??????Dragon????????????"),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
showHelp(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("?????????(Home)??????????????????\n\n?????????(Search)?????????????????????????????????"
        "Icon??????????????????????????????????????????Icon?????????????????????????????????????????????????????????*?????????"
        "??????????????????????????????????????????????????????????????????????????????????????????\n\n?????????(info)????????????"
        "???????????????app????????????"),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
showGitHub(BuildContext context) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text(""),
    actions: [
      ElevatedButton(
        child: Text("Close"),
        onPressed: () =>Navigator.of(context,rootNavigator: true).pop(),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
  );
}