import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/REST/Bisinesses/getBisiness.dart';
import 'package:omega_qick/Utils/DB/Bisiness/GetBusinessModel.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/BottomSheetEditHeadBuisness.dart';

import 'BodyBusiness.dart';

class BusinessPage extends StatefulWidget {

  bool edit = false;
  int id;

  BusinessPage(this.edit, this.id);
  factory BusinessPage.read(int id) => BusinessPage(false, id);
  factory BusinessPage.edit() => BusinessPage(true, null);


  Color colorPanelText1 = c5894bc;
  Color colorPanelText2 = Colors.white;
  double radiusPanelLeft = 0;
  double radiusPanelRight = 6;
  double paddingPanel = 0;
  int durationAnimatePanel = 100;
  int pagePanel = 0;


  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  Business business;

  String nameBiz = "";
  String textBiz = "";
  bool loading = true;
  //todo loading
  load()async{
    loading = true;
    setState(() {});

    print("BIZ ${widget.edit}");
    if(widget.edit) {
      String token = await tokenDB();
      InfoToken infoUser = await checkToken(token);
      if (infoUser != null && infoUser.role == 1&&widget.edit) {
        business = await getBusiness(infoUser.id);
        nameBiz = business.nameBusiness == null ? widget.edit
            ? "Редактируйте название"
            : "Магазин" : business.nameBusiness.length == 0 ? widget.edit
            ? "Редактируйте название"
            : "Магазин" : business.nameBusiness;
        textBiz = business.textShort == null
            ? widget.edit ? "Редактируйте описание" : ""
            : business.textShort.length == 0 ? widget.edit
            ? "Редактируйте описание"
            : "" : business.textShort;
        // nameBiz = business.nameBusiness != null?business.nameBusiness:business.nameBusiness.length ==0?widget.edit?"Редактируйте название":"Магазин":business.nameBusiness;
      }
    }else{
      business = await getBusiness(widget.id);
      nameBiz = business.nameBusiness == null ? widget.edit
          ? "Редактируйте название"
          : "Магазин" : business.nameBusiness.length == 0 ? widget.edit
          ? "Редактируйте название"
          : "Магазин" : business.nameBusiness;
      textBiz = business.textShort == null
          ? widget.edit ? "Редактируйте описание" : ""
          : business.textShort.length == 0 ? widget.edit
          ? "Редактируйте описание"
          : "" : business.textShort;
    }

    loading = false;
    setState(() {});
  }



  double minusIconsSize = 0;
  double minusFontsSize = 0;
  double heightAppBar = 0.42;

  bool searchFocus = false;

  PageController controller = PageController(
    keepPage: true,
    initialPage: 0,
  );

  void clickEmpty() {
    print("Start ${widget.pagePanel}");

    if (widget.pagePanel == 0) {
      setState(() {});
      controller.animateToPage(1,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    } else if (widget.pagePanel == 1) {
      setState(() {});
      controller.animateToPage(0,
          duration: Duration(milliseconds: 200), curve: Curves.ease);

      setState(() {});
      widget.pagePanel = 0;
    }
  }

  List<Widget> pages;

  @override
  void dispose() {
   // controller.dispose();
    super.dispose();

  }

  @override
  void initState() {
    // try {
      controller.addListener(() {
        widget.paddingPanel = controller.offset / 2;
        //print(controller.page);
        widget.pagePanel = controller.page.round();
        if (widget.pagePanel == 1) {
          widget.colorPanelText1 = Colors.white;
          widget.colorPanelText2 = c5894bc;
          widget.radiusPanelLeft = 6;
          widget.radiusPanelRight = 0;
        } else {
          widget.colorPanelText1 = c5894bc;
          widget.colorPanelText2 = Colors.white;
          widget.radiusPanelLeft = 0;
          widget.radiusPanelRight = 6;
        }
        setState(() {});
      });
    // }catch(e){}
    load();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light
      //       (
      //   //statusBarColor: cBackground,
      //   systemNavigationBarColor: Color(0x00cccccc),
      //   systemNavigationBarDividerColor: null,
      //   statusBarColor: Color(0xFFffffff),
      //   systemNavigationBarIconBrightness: Brightness.light,
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarBrightness: Brightness.light,
      // ),
    );


    pages = [
      BodyBusiness(type:0, edit: widget.edit, id: widget.id,),
      BodyBusiness(type:1, edit: widget.edit,id: widget.id,),
    ];
    setState(() {});

  }





  /*
    1 Заголовок
    2 описание
    3 фон картинка

    */

  tapEdit(int indexElement)async{
    switch(indexElement){
      case 0:{

       await  widget.edit?ShowBottomSheetEditHeadBusiness(context: context, name: nameBiz, textShort: textBiz,whereSave: (biz)async{load();} ):null;

        break;
      }
      case 1:{
        await widget.edit?ShowBottomSheetEditHeadBusiness(name: business.nameBusiness, context: context):null;
        break;
      }
      case 2:{
        //todo Клик по иконке редактировать фоон
        break;
      }
      case 3:{
        //todo Клик по иконке шапки справа
        break;
      }
      case 4:{
        Navigator.pop(context);
        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < 400) {
      heightAppBar = 0.46;
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }






    return Theme(
      data: ThemeData(primaryColor: Colors.transparent),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   centerTitle: true,
          //   leading: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: getIconForId(id: 0, color: cIcons, size: 24),
          //   ),
          //   // leading: Padding(
          //   //   padding: EdgeInsets.only(
          //   //     bottom: 20,
          //   //     right: 13,
          //   //   ),
          //   //   child: Icon(Icons.attach_money, size: 24),
          //   // ),
          //   // actions: [
          //   //   Padding(
          //   //     padding: EdgeInsets.only(bottom: 20, right: 10),
          //   //     child: Icon(Icons.attach_money, size: 24),
          //   //   )
          //   // ],
          //   title: Padding(
          //     padding: const EdgeInsets.only(bottom: 0),
          //     child: Container(
          //       color: cDefault,
          //       child: Center(child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
          //         child: Text(
          //           "Сохранить изменения"
          //         ),
          //       )),
          //     ),
          //   ),
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          // ),
          body:
              loading?Center(child: CircularProgressIndicator(),):Content(heightAppBar, minusFontsSize),
        ),
      ),
    );
  }

  Widget Content(double heightAppBar, double minusFontSize) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: cBG,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.width *1.3,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "lib/assets/images/bgb.png",
                fit: BoxFit.fill,
              )),
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: (MediaQuery.of(context).size.width) /
                  (MediaQuery.of(context).size.width * heightAppBar ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                            onTap: (){
                              tapEdit(4);
                            },
                            child: getIconForId(id: 0, size: 24, color: cIcons)),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: cDefault,
                      //       borderRadius: BorderRadius.circular(6)
                      //     ),
                      //     child: Center(child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      //       child: Text(
                      //           "Сохранить изменения",
                      //         style: TextStyle(color: cWhite, fontSize: 14, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal, fontFamily: fontFamily),
                      //       ),
                      //     )),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        //todo icon right
                        child: GestureDetector(
                            onTap: (){
                              tapEdit(2);
                            },
                            child: getIconForId(id: 0, size: 24, color: Colors.transparent)),
                      ),


                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [

                        Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTapUp: (we){},
                              onTap: (){
                                clickEmpty();
                                print("click");
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                              onTap:(){
                                                tapEdit(0);
                                              },
                                              child: Text(nameBiz,overflow: TextOverflow.ellipsis,style: TextStyle(color: cLinks, fontSize: 24, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontWeight: FontWeight.w400),)),
                                          GestureDetector(
                                              onTap: (){
                                                tapEdit(0);
                                              },
                                              child: Text(textBiz,overflow: TextOverflow.ellipsis, style: TextStyle(color: cLinks, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12),)),

                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 15,),
                                  Container(
                                    color: Colors.transparent,
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        AnimatedPadding(
                                          duration: Duration(milliseconds: widget.durationAnimatePanel),
                                          padding:  EdgeInsets.only(left:widget.paddingPanel),
                                          child: Container(
                                            color: Colors.transparent,
                                            width: MediaQuery.of(context).size.width * 0.50,
                                            child: GestureDetector(
                                              onTapUp: (d){},
                                              onTap: (){},
                                              child: AnimatedContainer(
                                                duration: Duration(milliseconds: widget.durationAnimatePanel),
                                                decoration: BoxDecoration(
                                                  color: cBG,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(widget.radiusPanelLeft),
                                                      topRight: Radius.circular(widget.radiusPanelRight)
                                                  ),
                                                ),
                                                height: 50,
                                                width:
                                                MediaQuery.of(context).size.width * 0.30,

                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Товары", style: TextStyle(color: widget.colorPanelText1, fontSize: 16- minusFontSize, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                                              ],
                                            ),
                                            Spacer(),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Услуги", style: TextStyle(color: widget.colorPanelText2, fontSize: 16 - minusFontSize, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Catalog(heightAppBar, minusFontSize)),
        ],
      ),
    );
  }

  Widget Catalog(double heightAppBar, double minusFontSize){
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: (MediaQuery.of(context).size.width) /
                (MediaQuery.of(context).size.width * heightAppBar),),
          Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width * heightAppBar - 24,
            child: PageView(
              controller: controller,
              children: pages,
            ),
          )

        ],
      ),
    );
  }


}
