import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:http/http.dart' as http;
Future<List<BlocSize>> getItems({int offset, int limit, int type})async{
  List<BlocSize> list = [
    // Product(name: "Носки",image: "http://194.226.171.139:14880/img/GL000392310.jpg",route: 1,text: "Носки для геев",price:10,sale:null),
    // Category(name: "Одежда",image: "https://get.wallhere.com/photo/illustration-anime-anime-girls-cartoon-headphones-Super-Sonico-screenshot-computer-wallpaper-93802.png",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Category(name: "Недвижимость",image: "http://pm1.narvii.com/6897/7c0ea975f5056c3e27255f53bbb7ba491a91154cr1-2048-1152v2_uhq.jpg",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Product(name: "Подарок",image: "https://images.by.prom.st/133109500_w640_h640_podarok.jpg",route: 1,text: "Внутри косарь",price:77,sale:null),
    // Product(name: "Носки",image: "https://mriya-resort.com/wp-content/uploads/2019/12/diving-to-flooded-aircraft.jpg",route: 1,text: "Носки для геев",price:10,sale:null),
    // Category(name: "Одежда",image: "https://get.wallhere.com/photo/Aisaka-Taiga-Taiga-Blyatsaka-Russia-vodka-Adidas-anime-Toradora-gopnik-1662225.jpg",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Category(name: "Недвижимость",image: "",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Product(name: "кНИГГА",image: "https://img4.goodfon.com/wallpaper/nbig/4/98/tavern-kniga-monety-art-fentezi-svecha-ozan-temelli.jpg",route: 1,text: "Внутри косарь",price:77,sale:null),
    // Product(name: "Носки",image: "https://basarab.ru/image/cache/catalog/new.socks/n-7/banana/DSC_0201-1022x766.jpg",route: 1,text: "Носки для геев",price:10,sale:null),
    // Category(name: "Одежда",image: "",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Category(name: "Недвижимость",image: "",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Product(name: "Подарок",image: "http://194.226.171.139:14880/img/GL000392310.jpg",route: 1,text: "Внутри косарь",price:77,sale:null),
    // Product(name: "Носки",image: "http://194.226.171.139:14880/img/GL000392310.jpg",route: 1,text: "Носки для геев",price:10,sale:null),
    // Category(name: "Одежда",image: "",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Category(name: "Недвижимость",image: "",route: 1, colors: [c2f527f, c7A8BA3, c2f527f]),
    // Product(name: "Подарок",image: "http://194.226.171.139:14880/img/GL000392310.jpg",route: 1,text: "Внутри косарь",price:77,sale:null),
  ];




  String url = "http://194.226.171.139:14880/apitest.php/feedconstructor";
  if(offset != null || limit != null || type != null){
    url += "?";
    int count =0;
    if(offset != null){
      if(count != 0)url+="&";
      url+="offset=$offset";
      count++;
    }
    if(limit != null){
      if(count != 0)url+="&";
      url+="limit=$limit";
      count++;
    }
    if(type != null){
      if(count != 0)url+="&";
      url+="type=$type";
      count++;
    }
  }

  print(url);
  var response = await http.get(url).timeout(Duration(seconds: 5));

  if(response.statusCode == 200){
    var decData = json.decode(response.body);
    print(decData);

    // list = [];

    for(int i = 0; i <decData.length; i++ ){
      if(decData[i]["blocksize"] == "1"){

        list.add( Category.fromJson(decData[i]));
      }else if(decData[i]["blocksize"] == "2"){
        list.add( ProductShort.fromJson(decData[i]));
      }
    }
  }







  return list;
}