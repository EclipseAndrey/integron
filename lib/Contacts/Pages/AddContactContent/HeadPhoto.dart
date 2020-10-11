import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget head(){
  return Container(
    height: 200,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 50,
            child: Text("Фото", style: TextStyle(color: Colors.black87),),backgroundColor: Colors.white,),
          Text("Добавить фото", style:  TextStyle(color:Color.fromRGBO(140 , 90, 252, 1), fontFamily: "MPLUS"),),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: Divider(color: Colors.white60,),
          )
        ],
      ),
    ),
  );
}