import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/AAPages/Blocs/Feed/UslugiCubit.dart';
import 'package:omega_qick/AAPages/Blocs/Feed/TovarsCubit.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';

import 'Panel/Panel.dart';

class Uslugi extends StatefulWidget {


  @override
  _UslugiState createState() => _UslugiState();
}

class _UslugiState extends State<Uslugi> with AutomaticKeepAliveClientMixin<Uslugi> {


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

  ProductShort product   = ProductShort(name: "Массаж",image: "https://massagkrasnodar.ru/wp-content/uploads/2018/07/th3.jpg",route: 1,text: "Внутри косарь",price:77,sale:null);
  Category category =  Category(name: "Здоровье",image: "https://grodnonews.by/upload/iblock/aa4/aa4a03c54a1354faebc0d0be72099d0f.jpg",route: 1, colors: [c2f527f, c7A8BA3, c2f527f], icon: 1);




   @override
  void initState() {
    controllerScroll.addListener(() {
      //print("listen scroll ${controllerScroll.position.pixels} // ${controllerScroll.position.maxScrollExtent}");
     // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
        print(controllerScroll.position.pixels);
        //todo autoload
      }
    });

  }


  // @override
  // void dispose() {
  //   controllerScroll.dispose();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context, ) {

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
      child: BlocBuilder<UslugiCubit,UslugiState>(
        builder: (context,state){
          if(state is UslugiLoading){
            return Center(child:  CircularProgressIndicator(),);
          }else if(state is UslugiComplete){
            return Loaded(state);
          }else if(state is UslugiSearch){
            return SearchResult(state);
          }else{
            return Center(
              //todo err
            );
          }
        },
      ),
    );
  }

  Widget Loaded(UslugiComplete uslugiComplete){

    List<BlocSize> leftColumn = [];
    List<BlocSize> rightColumn = [];

    List<BlocSize> list = uslugiComplete.uslugiList;
    for(int i = 0; i < list.length; i+=2){

      try{
        leftColumn.add(list[i]);
      }catch(e){}

      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }



    return  Container(
      color: cBG,
      child: Column(
        children: [
          MainPanel(context, product, category,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize,  voidCallbackCategory:(category){}),
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


  Widget SearchResult(UslugiSearch uslugiSearch){

    List<BlocSize> leftColumn = [];
    List<BlocSize> rightColumn = [];

    List<BlocSize> list = uslugiSearch.uslugiList;
    for(int i = 0; i < list.length; i+=2){

      try{
        leftColumn.add(list[i]);
      }catch(e){}

      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }



    return  Container(
      color: cBG,
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(left:12.0, top: 12, bottom:30, right: 12,),
            child: box(IconsSvg.search, uslugiSearch.input, (){
              BlocProvider.of<TovarsCubit>(context).closeWindow();
              BlocProvider.of<UslugiCubit>(context).closeWindow();
            }),
          ),
          uslugiSearch.uslugiList.length == 0? Center(child: Text("Хм, мы ничего не нашли", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24)),):Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize,  voidCallbackCategory:(category){}),
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
  bool get wantKeepAlive => false;
}
