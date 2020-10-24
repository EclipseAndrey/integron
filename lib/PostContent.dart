import 'package:flutter/material.dart';

import 'Head/Colors.dart';
import 'REST/Autorization/GetCode.dart';
import 'REST/Autorization/getCheckCode.dart';
import 'REST/SecureConnection/Connection.dart';
import 'Style.dart';
import 'package:http/http.dart' as http;
class PostContent extends StatefulWidget {
  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String text = "Место для контента";

  void loading ()async{
    String url;

  //  String a = await Connection.secure.crypto("YBLUDOK");
  //   print(a);



    //var r = await http.post("http://194.226.171.139:14880/api.php/post");
    //text = r.body;    setState(() {


  }

  @override
  void initState() {

    loading();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _drawerKey,



      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(32, 38 , 45, 1),
        shadowColor: Colors.transparent,


      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: homeBackgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.bottomCenter)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "MPLUS",
          ),
        )),
      ),
    );
  }
}
