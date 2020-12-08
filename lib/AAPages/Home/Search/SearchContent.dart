import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/Feed/UslugiCubit.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:integron/AAPages/Blocs/Feed/TovarsCubit.dart';

class SearchContent extends StatefulWidget {
  BuildContext blocContext;
  SearchContent(this.blocContext , {Key key}) : super(key: key);

  @override
  SearchContentState createState() => SearchContentState();
}

class SearchContentState extends State<SearchContent> {
  TextEditingController controllerInput = TextEditingController();
  FocusNode _focus = FocusNode();
  bool check = false;
  double left = 0;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void ProverkaPading() {
    if (check == true) {
      left =  MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.20) - 22;
      height = 0.64;
      iconColor = Colors.blueAccent;
      containerColor = Colors.white;
      setState(() {});
    } else if (check == false) {
      left = MediaQuery.of(context).size.width * 0.5- (MediaQuery.of(context).size.width * 0.20);
      height = 0.0;
      iconColor = null;
      containerColor = null;
      setState(() {});
    }
  }

  void _onFocusChange() {
    check = _focus.hasFocus;
    print(check);
    ProverkaPading();
  }

//0.6
  double height = 0.0;
  Color iconColor = null;
  Color containerColor = null;
  Color containerSearchColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focus);
    ProverkaPading();
    return Content();
  }

  Widget inputText() {
    return TextField(
      focusNode: _focus,
      controller: controllerInput,
      obscureText: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(153, 155, 158, 1),
        ),
        hintText: "Что ищем?",
      ),
    );
  }

  Widget buttonSearch() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      decoration: BoxDecoration(
        color: c8dcde0,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          Icons.search,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget containerBorder() {
    double p = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Stack(
        children: [
          AnimatedPadding(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.only(top: 2.0, bottom: 2, left: left),
            child: InkWell(
                onTap: (){
                  if(controllerInput.text == ""){
                    closeDialog(context);
                  }else{
                    BlocProvider.of<TovarsCubit>(widget.blocContext).search(controllerInput.text);
                    BlocProvider.of<UslugiCubit>(widget.blocContext).search(controllerInput.text);
                    closeDialog(context);
                  }
                },
                child: buttonSearch()),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0,bottom: 2, left: 10, right: MediaQuery.of(context).size.width*0.20+10),
            child: inputText(),
          ),
        ],
      ),
    );
  }

  Widget contentSearch() {
    List<ItemContentSearch> list = [
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
      // ItemContentSearch(Icons.star, "Компьютерные игры"),
    ];



    Widget item(ItemContentSearch i){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(i.icon, color: c6287A1,),
            SizedBox(width: 6,),
            Container(
                width: MediaQuery.of(context).size.width*0.40- 30,

                child: Text(i.text, style: TextStyle(color: cMainText, fontSize: 14, fontWeight: FontWeight.w600),))
          ],
        ),
      );
    }



    Widget generatorCategory(List<ItemContentSearch> list){
      int lenL;
      int lenR;
      if(list.length%2 == 0){
        lenL = list.length~/2;
        lenR = list.length~/2;
      }else{
        lenL = list.length~/2;
        lenL = list.length~/2-1;

      }


      return Padding(
        padding: const EdgeInsets.only(top: 55.0),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: List.generate(lenL, (index) => item(list[index*2])),
              ),
              Column(
                children: List.generate(lenR, (index) => item(list[index*2+1])),
              ),
            ],
          ),
        ),
      );
    }




    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      alignment: Alignment.topCenter,
      // width: MediaQuery.of(context).size.width * 0.975,
      //height: MediaQuery.of(context).size.height * height,
      child:
      generatorCategory(list),
    );





  }

  Widget Content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Stack(
            children: [
              contentSearch(),
              containerBorder(),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemContentSearch{
  String text;
  IconData icon;
  ItemContentSearch(this.icon,this.text);
}