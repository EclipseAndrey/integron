import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/My/Buisness/Buisness.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/Items/Set.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/AddProductInCart.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';
import 'package:omega_qick/Utils/fun/DialogIntegron.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogError.dart';
import 'package:omega_qick/main.dart';

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
      Function(int route) tapUpFull
    }){

  double h = MediaQuery.of(context).size.width*0.60;
  double w =MediaQuery.of(context).size.width*0.26;
  String name;
  bool imageF;
  List<Color> colors;

  print("Item getter $edit");


  name = bloc.name;
  h = bloc.blocSize == 1?MediaQuery.of(context).size.width*0.26:MediaQuery.of(context).size.width*0.60;
  w = MediaQuery.of(context).size.width*0.45;
  if(bloc.image == ""||bloc.image == null||bloc.image == "null"){
    imageF = false;
    colors = [c2f527f,c5894bc,c8dcde0];
  }else{
    imageF = true;
  }


  Widget _content(int size){

    if(size == 2){
      ProductShort bloc2 = bloc;
      return Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.width*0.30,
                  child: imageF?Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                            child: Image.network(bloc.image, fit: BoxFit.cover,)),
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
                                    child: getIconForId(id: 38, color: cIcons)),
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
                          width: MediaQuery.of(context).size.width*0.45,
                          height: MediaQuery.of(context).size.width*0.30,
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
                                    child: getIconForId(id: 38, color: cIcons)),
                              ),
                            ),
                          ),
                        ),
                      ):SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 9, right: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,       overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                      Padding(
                        padding: const EdgeInsets.only(top:6.0),
                        child: Container(
                          child: Text(bloc2.text??"null",
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
              width: MediaQuery.of(context).size.width*0.45,
              decoration: BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("${bloc2.price} ",  style: TextStyle(color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
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
                        FocusedMenuItem(title: Text("Редактировать",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconForId(id: 44,color: c6287A1),onPressed: (){tapEdit(bloc.route);}),
                        FocusedMenuItem(title: Text("В самый верх",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconForId(id: 44,color: c6287A1),onPressed: (){tapUpFull(bloc.route);}),
                        FocusedMenuItem(title: Text("Удалить",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconForId(id: 44,color: c6287A1),onPressed: (){tapDelete(bloc.route);}),

                      ]:<FocusedMenuItem>[
                        // Add Each FocusedMenuItem  for Menu Options
                        FocusedMenuItem(title: Text("В корзину",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.open_in_new) ,iconCustom: getIconForId(id: 55,color: c6287A1),onPressed: ()async{
                          AddProductInCart(context,bloc.route);
                        }),
                        FocusedMenuItem(title: Text("В магазин",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.share),iconCustom: getIconForId(id: 44,color: c6287A1),onPressed: (){

                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusinessPage.read(bloc2.ownerIdS)));
                        }),
                     //   FocusedMenuItem(title: Text("В избранное",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.favorite_border),iconCustom: getIconForId(id: 15,color: c6287A1) ,onPressed: (){}),
                        //FocusedMenuItem(title: Text("Похожее",style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontSize: 14),),trailingIcon: Icon(Icons.delete,color: Colors.redAccent,),iconCustom: getIconForId(id: 40,color: c6287A1) ,onPressed: (){
                        //   showDialogIntegron(context: context, title: Text("Helo i'm text", style: TextStyle(color: cMainText, fontSize: 16),), body: Text("Hello, i'm body this custom dialog ebpta and i should be very big arere dic andrey", style: TextStyle(color: cMainText, fontSize: 16), ), buttons: <DialogIntegronButton>[DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){}),DialogIntegronButton(textButton: Text("Button", style: TextStyle(color: cMainText, fontSize: 16),), onPressed: (){})]);}),
                      ],
                      onPressed: (){},
                      child: Container(
                          width: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              getIconForId(id: 29, color: c2f527f, size: 18,),
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
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.width*0.30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: imageF?ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(bloc.image, fit: BoxFit.cover,
                      )):Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: MediaQuery.of(context).size.width*0.30,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconForId(id: category.icon,color: Colors.white, size: 24 - minusIconSize,),
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

  if(!(add??false))return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: (){
         bloc.blocSize==2?Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(bloc.route))):null;

      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.45,
        height:  h,
        decoration: BoxDecoration(
          boxShadow: bloc.blocSize == 0?[]:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(6),
          color:Colors.white ,
        ),
        child: _content(bloc.blocSize),
      ),
    ),
  );

  else{
    double h = MediaQuery.of(context).size.width * 0.60;
    double w = MediaQuery.of(context).size.width*0.45;

    return Padding(
      padding:  EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: tapAdd,
        child: Container(
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(6),
            // padding: EdgeInsets.all(12),
            dashPattern: [12],
            color: cd1d3d7,
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getIconForId(id: 13, color: cIcons),
                    Text("Добавить товар", style: TextStyle(color: cLinks, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}


