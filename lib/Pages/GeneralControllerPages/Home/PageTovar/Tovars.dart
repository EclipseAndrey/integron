import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/AAPages/Blocs/Feed/TovarsCubit.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/PageUslig/Panel/Panel.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';





// abstract class callCategory{
//
//   callCategory();
// }


class Tovars extends StatefulWidget {

  VoidCallbackCategory callbackCategory;
  PageController controllerPages;

  Tovars(this.callbackCategory,this.controllerPages);



  @override
  _TovarsState createState() => _TovarsState();
}

class _TovarsState extends State<Tovars> with AutomaticKeepAliveClientMixin<Tovars>{


  double minusIconsSize = 0;
  double minusFontsSize = 0;



  ScrollController controllerScroll = ScrollController();

  ProductShort product   = ProductShort(name: "кНИГГА",image: "https://img4.goodfon.com/wallpaper/nbig/4/98/tavern-kniga-monety-art-fentezi-svecha-ozan-temelli.jpg",route: 1,text: "Внутри косарь",price:77,sale:null);
  Category category =  Category(name: "Одежда",image: "https://get.wallhere.com/photo/illustration-anime-anime-girls-cartoon-headphones-Super-Sonico-screenshot-computer-wallpaper-93802.png",route: 1, colors: [c2f527f, c7A8BA3, c2f527f],icon: 1);





  @override
  void initState() {


    controllerScroll.addListener(() {
      // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
        print(controllerScroll.position.pixels);
        //todo AutoLoad
      }
    });

  }

  @override
  Widget build(BuildContext context) {


    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }

    super.build(context);
    return SingleChildScrollView(
      controller: controllerScroll,
      child: BlocBuilder<TovarsCubit,TovarsState>(
        builder: (context, state){
          if(state is TovarsLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is TovarsComplete){
            return Loaded(state);
          }else{
            return Center(
              //todo err
            );
          }
        },
      ),
    );
  }

  Widget Loaded(TovarsComplete tovarsComplete){

    List<BlocSize> leftColumn = [];
    List<BlocSize> rightColumn = [];


    List<BlocSize> list = tovarsComplete.tovarsList;
    for(int i = 0; i < list.length; i+=2){
      try{
        leftColumn.add(list[i]);
      }catch(e){}

      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }


    return Container(
      color: cBG,
      child: Column(
        children: [
          MainPanel(context, product,category,widget.controllerPages),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(leftColumn.length, (index) => ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory)) ,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: List.generate(rightColumn.length, (index) => ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory)) ,
                ),
              ],
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive =>  false;
}
