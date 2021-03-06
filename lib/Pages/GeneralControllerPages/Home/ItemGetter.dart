import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:integron/Pages/GeneralControllerPages/My/Buisness/Buisness.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Products/Set.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/AddProductInCart.dart';
import 'package:integron/Utils/fun/Callbcks.dart';
import 'dart:ui' as ui show Image, ImageFilter, TextHeightBehavior;

import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';
import 'package:integron/main.dart';



Widget ItemGetter(
    BlocSize bloc,
    BuildContext context,
    double minusFontSize,
    double minusIconSize,
    {VoidCallbackCategory voidCallbackCategory,
      bool arrowUp,
      bool add,
      Function(int route) tapUpOnly,
      bool edit,
      Function tapAdd,
      Function(int route) tapDelete,
      Function(int route) tapEdit,
      Function(int route) tapUpFull,
      Function(int route, int hidden) tapHidden,
      Function(int id, bool setValue) setFavorite,
    }){



  double c = 12;
  double edge = 18;
  double h2= 0;
  double h1= 0;
  double h0= 0;
  double h= 0;
  double w =0;
  /// [c] - отсуп по центру между элементами
  /// [edge] - отступ по краям
  /// [h2] - высота блока 2
  /// [h1] - высота блока 1
  /// [h0] - высота блока 0
  /// [w] - стандартная ширина элемента
  w =  MediaQuery.of(context).size.width/2 - c/2 - edge;
  h2  = w*1.50;
  h1  = w*0.72;
  h0  = w*0.33;
  h = bloc.blocSize == 1?h1:h2;


  bool imageF;
  List<Color> colors;


  if(bloc.image == ""||bloc.image == null||bloc.image == "null"){
    imageF = false;
    colors = [c2f527f,c5894bc,c8dcde0];
  }else{
    imageF = true;
  }


  Widget _content(int size){

    if(size == 2){
      Product blocProduct = bloc;
      return Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [

                    Container(
                      width: w,
                      height: h*0.54,

                      child: imageF?Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: w,
                              height: h*0.54,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                  child: Image.network(bloc.image, fit: BoxFit.cover,)),
                            ),
                          ),
                          (edit??false)?Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: GestureDetector(
                                onTap: (){
                                  print('tap Only Item getter');
                                  tapUpOnly(bloc.route);},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cDefault,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    // todo padding?
                                    child: Transform.rotate(
                                        angle: 180 * 3.14 / 180,
                                        child: getIconSvg(id: 38, color: cIcons)),
                                  ),
                                ),
                              ),
                            ),
                          ):SizedBox(),
                        ],
                      ):Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: w,
                              height: h*0.54,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: colors
                                  )
                              ),
                            ),
                          ),
                          (edit??false)?Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  print('tap Only Item getter');
                                  tapUpOnly(bloc.route);},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cDefault,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Transform.rotate(
                                        angle: 180 * 3.14 / 180,
                                        child: getIconSvg(id: 38, color: cIcons)),
                                  ),
                                ),
                              ),
                            ),
                          ):SizedBox(),
                        ],
                      ),
                    ),
                    (bloc is Product)?bloc.hidden == 1?ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      child: Container(
                        color: Colors.black.withOpacity((bloc is Product)?bloc.hidden == 1? 0.6:0:0),
                        width: w,
                        height: h*0.54,
                        child: (bloc is Product)?bloc.hidden == 1?Center( child:  getIconSvg(id: IconsSvg.eyeClosed, size: 30),):SizedBox():SizedBox(),
                      ),
                    ):SizedBox():SizedBox(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: c, top: c, right: c),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bloc.name,  overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                      Padding(
                        padding:  EdgeInsets.only(top:6.0),
                        child: Container(
                          child: Text(bloc is ProductShort?bloc.text:bloc is Product? bloc.text??"null":'null',
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: c7A8BA3, fontSize: 10, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [cWhite.withOpacity(0),cWhite, cWhite,cWhite,cWhite],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),

                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),

              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 9.0, vertical: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("${bloc is ProductShort?bloc.price:bloc is Product? bloc.price??"null":'null'} ",  style: TextStyle(color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                        Text("DEL",  style: TextStyle(color: c2f527f, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),)
                      ],
                    ),
                    // Drop(),

                    FocusedMenuHolder(
                      menuWidth: MediaQuery.of(context).size.width*0.50,
                      blurSize: 0.0,
                      menuItemExtent: 45,
                      menuBoxDecoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      duration: Duration(milliseconds: 1),
                      animateMenuItems: false,
                      blurBackgroundColor: Colors.transparent,
                      menuOffset: 10.0, // Offset value to show menuItem from the selected item
                      bottomOffsetHeight: 80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
                      menuItems: (edit??false)?<FocusedMenuItem>[
                        FocusedMenuItem(title: Text("Редактировать",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: IconsSvg.edit,color: c6287A1),onPressed: (){tapEdit(bloc.route);}),
                        FocusedMenuItem(title: Text("В самый верх",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: IconsSvg.moveTop,color: c6287A1),onPressed: (){tapUpFull(bloc.route);}),
                        FocusedMenuItem(title: Text((bloc is Product)?bloc.hidden == 0?"Скрыть":"Показать":"",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: (bloc is Product)?bloc.hidden == 0?IconsSvg.eyeClosed:IconsSvg.eye:40,color: c6287A1),onPressed: (){tapHidden(bloc.route,  (bloc is Product)?bloc.hidden:0);}),
                        FocusedMenuItem(title: Text("Удалить",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: 44,color: c6287A1),onPressed: (){tapDelete(bloc.route);}),

                      ]:FullVersion?<FocusedMenuItem>[
                        // Add Each FocusedMenuItem  for Menu Options
                        FocusedMenuItem(title: Text("В корзину",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.open_in_new) ,iconCustom: getIconSvg(id: 55,color: c6287A1),onPressed: ()async{
                          AddProductInCart(context,bloc.route);
                        }),
                        FocusedMenuItem(title: Text("В магазин",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: 44,color: c6287A1),onPressed: (){

                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusinessPage.read(bloc is ProductShort?bloc.ownerIdS:bloc is Product? bloc.owner??"0":'0')));
                        }),
                        FocusedMenuItem(title: Text("В избранное",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.favorite_border),iconCustom: getIconSvg(id: 15,color: c6287A1) ,onPressed: (){
                          //setFavorite(blocProduct.route, true);
                          ProductProvider.setFavorite(blocProduct.route, true);
                          showDialogIntegron(context: context, title: Image.asset('lib/assets/images/add-favorite.png',), body: Text('Товар добавлен в избранное!', textAlign: TextAlign.center, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,fontFamily: fontFamily),));

                        }),
                        //FocusedMenuItem(title: Text("Похожее",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.delete,color: Colors.redAccent,),iconCustom: getIconForId(id: 40,color: c6287A1) ,onPressed: (){
                        //   showDialogIntegron(context: context, title: Text("Helo i'm text", style: TextStyle(color: cMainText, fontSize: 16),), body: Text("Hello, i'm body this custom dialog ebpta and i should be very big arere dic andrey", style: TextStyle(color: cMainText, fontSize: 16), ), buttons: <DialogIntegronButton>[DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){}),DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){})]);}),
                      ]:<FocusedMenuItem>[
                        FocusedMenuItem(title: Text("В магазин",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconSvg(id: 44,color: c6287A1),onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusinessPage.read(bloc is ProductShort?bloc.ownerIdS:bloc is Product? bloc.owner??"0":'0')));
                        }),
                        FocusedMenuItem(title: Text("В избранное",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.favorite_border),iconCustom: getIconSvg(id: 15,color: c6287A1) ,onPressed: (){
                          //setFavorite(blocProduct.route, true);
                          ProductProvider.setFavorite(blocProduct.route, true);
                          showDialogIntegron(context: context, title: Image.asset('lib/assets/images/add-favorite.png',), body: Text('Товар добавлен в избранное!', textAlign: TextAlign.center, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,fontFamily: fontFamily),));

                        }),
                        //FocusedMenuItem(title: Text("Похожее",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.delete,color: Colors.redAccent,),iconCustom: getIconForId(id: 40,color: c6287A1) ,onPressed: (){
                        //   showDialogIntegron(context: context, title: Text("Helo i'm text", style: TextStyle(color: cMainText, fontSize: 16),), body: Text("Hello, i'm body this custom dialog ebpta and i should be very big arere dic andrey", style: TextStyle(color: cMainText, fontSize: 16), ), buttons: <DialogIntegronButton>[DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){}),DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){})]);}),
                      ],
                      onPressed: (){},
                      child: Container(
                          width: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              getIconSvg(id: 29, color: c2f527f, size: 18,),
                            ],
                          )),
                    ),


                  ],
                ),
              ),
            ),
          )
        ],
      );

    }else
      if(size == 1){

      Category category = bloc;
      return Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              child: GestureDetector(
                onTap: (){voidCallbackCategory(bloc);},
                child: Container(
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: imageF?ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(bloc.image, fit: BoxFit.cover,
                      )):Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                            colors: colors
                        )
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconSvg(id: category.icon,color: Colors.white, size: 24 - minusIconSize,),
                  // Icon(Icons.star, color: Colors.white, size: 24 - minusIconSize,),
                  Text(bloc.name, style: TextStyle(color: Colors.white, fontSize: 16 - minusFontSize, fontWeight: FontWeight.w700, fontFamily: fontFamily),)
                ],
              ),
            ),

          ),

        ],
      );
    }else
      if(size == 3){
      SetBloc bloc2 = bloc;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.45,
            height: MediaQuery.of(context).size.width*0.30,
            child: imageF?ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),

                child: Image.network(bloc.image, fit: BoxFit.cover,)):Container(
              width: MediaQuery.of(context).size.width*0.45,
              height: MediaQuery.of(context).size.width*0.30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: colors
                  )
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Summ ",  style: TextStyle(color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                    Text("DEL",  style: TextStyle(color: c2f527f, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),)
                  ],
                ),
                Icon(Icons.arrow_forward, color: c2f527f, size: 18,)
              ],
            ),
          )

        ],
      );
    }

  }

  if(!(add??false))return GestureDetector(
    onTap: (){
       bloc.blocSize==2?Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(bloc.route))):null;
    },
    child: Container(
      width: w,
      height:  h,
      decoration: BoxDecoration(
        boxShadow: bloc.blocSize == 0?[]:shadowContainer,
        borderRadius: BorderRadius.circular(6),
        color:Colors.white ,
      ),
      child: _content(bloc.blocSize),
    ),
  );

  else{
    // double h = MediaQuery.of(context).size.width * 0.60;
    // double w = MediaQuery.of(context).size.width*0.45;

    return GestureDetector(
      onTap: tapAdd,
      child: Container(
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(6),
          // padding: EdgeInsets.all(12),
          dashPattern: [12],
          color: cd1d3d7,
          child: Container(
            height: h-6,
            width: w-6,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getIconSvg(id: 13, color: cIcons),
                  Text("Добавить товар", style: TextStyle(color: cLinks, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}


