import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Providers/BizProvider/BizProvider.dart';
import 'package:integron/REST/Autorization/checkToken.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:integron/Utils/DB/Biz/Business.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/BottomDialogs/BottomSheetEditHeadBuisness.dart';
import 'package:integron/Utils/fun/Logs.dart';
import 'package:integron/Utils/fun/TabPanel/TabPanel.dart';

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

  TabBarProductController tabBarProductController;
  GlobalKey key = GlobalKey();

  bool hide = false;
  double height;

  Business business;

  String nameBiz = "";
  String textBiz = "";
  bool loading = true;
  load()async{
    loading = true;
    setState(() {});

    print("BIZ ${widget.edit}");
    if(widget.edit) {
      InfoToken infoUser = await checkToken(context);
      if (infoUser != null && infoUser.role == 1&&widget.edit) {
        business = await BizProvider.getBusiness(infoUser.id);
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
      business = await BizProvider.getBusiness(widget.id);
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
    WidgetsBinding.instance.addPostFrameCallback((_) => initHeader());
    // if(height == null)height = key.currentContext.size.height;

  }



  double minusIconsSize = 0;
  double minusFontsSize = 0;
  double heightAppBar = 0.26;

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


    tabBarProductController = TabBarProductController();
    tabBarProductController.addListener((index) {
      controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });

    // try {
      controller.addListener(() {
        if(controller.page.round() != tabBarProductController.currentPage){
          tabBarProductController.jumpToPage(controller.page.round());
        }
      });

    // }catch(e){}
    load();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle//.dark
          (
          //statusBarColor: cBackground,
          systemNavigationBarColor: Color(0x00cccccc),
          systemNavigationBarDividerColor: Color(0x00cccccc),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Color(0xFFeef0f3),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      );

      void onDrag(bool up){
        if(hide == up) {
          print('tap header');
          //todo
          height == null ? height = key.currentContext.size.height : null;
          hide = !up;
          tabBarProductController.hide(hide);
          setState(() {});
        }
      }

    pages = [
      BodyBusiness(type:0, edit: widget.edit, id: widget.id, onDrag: onDrag,),
      BodyBusiness(type:1, edit: widget.edit,id: widget.id,onDrag: onDrag),
      BodyBusiness(type:2, edit: widget.edit,id: widget.id,onDrag:onDrag),
    ];
    setState(() {});

  }

  initHeader(){
    print('ini');
    if(height == null)height = key.currentContext.size.height;
    setState(() {});
  }

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
        setImage();
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
      heightAppBar = 0.32;
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }



    return Theme(
      data: ThemeData(primaryColor: Colors.transparent),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
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
          Positioned(
            top: 0,
            child: GestureDetector(
                onTap: (){
                  print('tap header');
                  //todo
                  height == null ? height = key.currentContext.size.height : null;
                  hide = false;
                  tabBarProductController.hide(hide);
                  setState(() {});
                },
                child: background()),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        buttons(),
                        AnimatedContainer(
                          key: key,
                            duration: Duration(milliseconds: 200),
                            height: hide?0:height,
                            // height: hide?0:,
                            constraints: BoxConstraints(
                            ),
                            child: AnimatedOpacity(
                                opacity: hide?0:1,
                                duration: Duration(milliseconds: 200),
                                child: descShop())),
                        // hide?SizedBox():descShop(),
                      ],
                    ),
                ),

                TabBarProducts(
                  controller: tabBarProductController,
                  names: ['Товары','Услуги', 'Обучение'],
                ),
                Catalog(heightAppBar, minusFontSize)
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              //child: Catalog(heightAppBar, minusFontSize),
          ),
        ],
      ),
    );
  }

  Widget background(){
    return Container(
        height: MediaQuery.of(context).size.width *0.5,
        width: MediaQuery.of(context).size.width,
        child: (business.photo == null)|| business.photo == ""?Image.asset(
          "lib/assets/images/bgb.png",
          fit: BoxFit.fill,
        ):Image.network(business.photo, fit: BoxFit.cover,));
  }

  Widget buttons (){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
              onTap: (){
                tapEdit(4);
              },
              child: getIconSvg(id: 0, size: 24, color: cIcons)),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: hide?1:0,
          child: Text(nameBiz,overflow: TextOverflow.ellipsis,style: TextStyle(color: cLinks, fontSize: 24, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontWeight: FontWeight.w400),),
        ),
        widget.edit?Padding(
          padding: const EdgeInsets.all(12.0),
          //todo icon right
          child: GestureDetector(
              onTap: (){
                tapEdit(2);
              },
              child: getIconSvg(id: IconsSvg.image, size: 24, color: cIcons)),
        ):SizedBox(),
      ],
    );
  }

  Widget descShop(){
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
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

                  ],
                ),
              )),

        ],
      ),
    );
  }

  Widget Catalog(double heightAppBar, double minusFontSize){
    return Container(
      width: (MediaQuery.of(context).size.width),
      //height: (MediaQuery.of(context).size.height),
      child: Column(
        children: [

          // AspectRatio(
          //   aspectRatio: (MediaQuery.of(context).size.width) /
          //       (MediaQuery.of(context).size.width * heightAppBar),),

          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width * heightAppBar - (hide?-40:74) ,
            child: PageView(
              controller: controller,
              children: pages,
            ),
          )

        ],
      ),
    );
  }


  setImage()async{
    final picker = ImagePicker();
    String path = "";
    PickedFile pickedFile;
    printL("Запуск галереи");
    try {
      pickedFile = await picker.getImage(

        source: ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
        imageQuality: 100,

      );
      printL("Успешно выбраны фото");
    }catch(e){
      //todo send logs
      printL(e);
      // Clipboard.setData(ClipboardData(text: copyText));
    }

    setState(() {});
    if (pickedFile != null) {
      path = pickedFile.path;

      String url = "http://194.226.171.139:14880/apitest.php/uploadPhoto";
      printL("Upload photo on Server");
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
          http.MultipartFile(
              'var_file',
              File(path).readAsBytes().asStream(),
              File(path).lengthSync(),
              filename: path.split("/").last
          )
      );
      var res = await request.send();
      //     .then((value){
      //
      // });
      //print("req "+ res.request.toString());


      res.stream.transform(utf8.decoder).listen((value) async{
        print(value);
        await BizProvider.setBizPhoto(json.decode(value)['url']);
        load();
      });
      printL("Upload photo on Server complete");




    } else {
      printL('No image selected.');
    }

  }





}


