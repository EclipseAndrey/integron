import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/Feed/TovarsCubit.dart';
import 'package:integron/AAPages/Blocs/Feed/UslugiCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/AAPages/Home/PageUslig/Panel/Panel.dart';





// abstract class callCategory{
//
//   callCategory();
// }


class Tovars extends StatefulWidget {
  @override
  _TovarsState createState() => _TovarsState();
}

class _TovarsState extends State<Tovars> with AutomaticKeepAliveClientMixin<Tovars>{


  double minusIconsSize = 0;
  double minusFontsSize = 0;

  /// [c] - отсуп по центру между элементами
  /// [edge] - отступ по краям
  /// [h2] - высота блока 2
  /// [h1] - высота блока 1
  /// [h0] - высота блока 0
  /// [w] - стандартная ширина элемента
  /// [p] - отступ в 4%

  double c = 12;
  double edge = 18;
  double h2= 0;
  double h1= 0;
  double h0= 0;
  double w =0;
  double p =0;


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


    w =  MediaQuery.of(context).size.width/2 - c/2 - edge;
    h2  = w*1.50;
    h1  = w*0.72;
    h0  = w*0.33;

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
          }else if(state is TovarsSearch){
            return SearchResult(state);
          } else{
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
          MainPanel(context, product,category,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SizedBox(width: edge,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length, (index) => Column(
                  children: [
                    ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: (category){}),
                    SizedBox(height: c,),
                  ],
                )) ,
              ),
              SizedBox(width: c,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(rightColumn.length, (index) => Column(
                  children: [
                    ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: (category){/* todo callback */ },
                    setFavorite: (route, setValue){

                    }
                    ),
                    SizedBox(height: c,),

                  ],
                )) ,
              ),
              SizedBox(width: edge,),

            ],
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }

  Widget SearchResult(TovarsSearch tovarsSearch){

    List<BlocSize> leftColumn = [];
    List<BlocSize> rightColumn = [];


    List<BlocSize> list = tovarsSearch.tovarsList;
    for(int i = 0; i < list.length; i+=2){


        leftColumn.add(list[i]);


      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }




    return Container(
      color: cBG,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left:12.0, top: 12, bottom:30, right: 12,),
            child: box(IconsSvg.search, tovarsSearch.input, (){
              BlocProvider.of<TovarsCubit>(context).closeWindow();
              BlocProvider.of<UslugiCubit>(context).closeWindow();
            }),
          ),

          tovarsSearch.tovarsList.length == 0? Center(child: Text("Хм, мы ничего не нашли", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24)),):Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SizedBox(width: edge,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length, (index) {
                  print("GENERATE");
                  return  Column(
                  children: [
                    ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: (category){}),
                    SizedBox(height: c,),

                  ],
                );}) ,
              ),
              SizedBox(width: c,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(rightColumn.length, (index) => Column(
                  children: [
                    ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: (category){/* todo callback */ }),
                    SizedBox(height: c,),

                  ],
                )) ,
              ),
              SizedBox(width: edge,),

            ],
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }



  Widget box(int icon, String text, Function onTap){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 245, 239, 1),
            borderRadius: BorderRadius.circular(6),

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: getIconSvg(id:icon, color: c6287A1, size: 20,),
                ),
                SizedBox(width: 8,),
                Text(text??"Empty", style: TextStyle(
                    color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400, fontFamily: fontFamily
                ),),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    child: getIconSvg(id:8, color: c6287A1, size: 18,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  @override
  bool get wantKeepAlive =>  false;
}
