import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omega_qick/Head/CardWallet.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/Parse/tx.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:tabbar/tabbar.dart';

import '../JsonParse.dart';
import 'Balance.dart';
import 'Wallet.dart';

class Header extends StatefulWidget {
  PageController controller;
  List<User> users;




  Header(this.users, this.controller);
  @override
  _HeaderState createState() => _HeaderState(controller);
}

class _HeaderState extends State<Header> {


  bool loading = false;

  PageController controller;
  _HeaderState( this.controller);








  @override
  Widget build(BuildContext context) {



    return ControllerHeader(widget.users, context, controller);
  }
  double offset = 0;



  Widget ControllerHeader(List<User> user,BuildContext context, PageController controller ){

    var size = MediaQuery.of(context).size;



    controller.addListener(() {
      setState(() {
        offset = controller.offset;
      });
    });
    return Container(
      width:  size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,

            height: size.width*0.80*0.70,
            child: loading? Center(child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ),):TabbarContent(

              controller: controller,
              children: List.generate(user.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardWallet(user[index],context),
                );
              }),
            ),
          ),
          user==null? SizedBox():Padding(
            padding:  EdgeInsets.only(left: 15.0, top: 4),
            child: Container(height: 2,
              color: Colors.white30, //full panel
              width: size.width-30,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1),
                    left:  offset/user.length,
                    child: Container(
                      height: 2,
                      color: Colors.white60, //switch
                      width: size.width/user.length - 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );


  }
}


