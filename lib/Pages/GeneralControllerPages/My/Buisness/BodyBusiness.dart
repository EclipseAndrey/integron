import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/My/PageAddProduct.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/REST/Bisinesses/getBisiness.dart';
import 'package:omega_qick/REST/Bisinesses/upFullPost.dart';
import 'package:omega_qick/REST/Bisinesses/upOnlyPost.dart';
import 'package:omega_qick/REST/Home/Search/getItemCategory.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

class BodyBusiness extends StatefulWidget {

  bool edit;
  int type;
  BodyBusiness({this.type, this.edit});

  @override
  _BodyBusinessState createState() => _BodyBusinessState();
}

class _BodyBusinessState extends State<BodyBusiness> with AutomaticKeepAliveClientMixin<BodyBusiness>{

  int weiR = 0;
  int weiL = 0;

  double minusIconsSize = 0;
  double minusFontsSize = 0;

  List<BlocSize> leftColumn = [];
  List<BlocSize> rightColumn = [];


  bool loading = true;



  ScrollController controllerScroll = ScrollController();
  List list;

  void getItemsfromServ()async{
    loading = true;
    setState(() {});

    List<BlocSize> listStep = widget.edit?[Product(ownerName: null, delivery: null, fullText: null, unit: null, detail: [], text: null, type: null, catPath: [], property: [], name: null, image: null, owner: null, price: null, images: [    ], route: null)]:[];

    String token = await  tokenDB();
    InfoToken infoToken = await checkToken(token);
    var biz = await getBusiness(infoToken.id);
    list = biz.products;
    print("body loading ${list.length} элементов при инициализации в list");
    print("body loading ${listStep.length} элементов при инициализации в listStep");


    for(int i =0; i < list.length; i++){
        Product pSortStep = list[i] as Product;
        // try {
          print("type Body ${list[i]==null}  ${ widget.type}");

          if ((list[i] == null ?0: (list[i].type == null?0:list[i].type)) == widget.type)
            listStep.add(list[i]);
        // }catch(e){print(e);}
    }
    print("body loading ${list.length} элементов after load в list");
    print("body loading ${listStep.length} элементов after load в listStep");
    list = listStep;

    leftColumn = [];
    rightColumn = [];
    for(int i = 0; i < list.length; i+=2){

      try {
        leftColumn.add(list[i]);
      }catch(e){}
      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }
    print("body loading ${list.length} элементов after sort в list");
    print("body loading ${listStep.length} элементов after sort в listStep");
    print("body loading ${leftColumn.length} left ${rightColumn.length} right ");


    loading = false;
    setState(() {

    });
  }

  //todo
  tapDelete(int route){
    print("tap delete");
  }
  tapEdit(int route)async{
    print("Body 56 ADD");
    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: true,id: route,)));
    getItemsfromServ();
  }
  //todo
  tapUpFull(int route)async{
    print("tapUpFull");
    await upFullPost(route);
    getItemsfromServ();
  }
  //todo
  tapUpOnly(int route)async{
    try {
      int route2 = 0;
      print("tap up Body $route");
      for (int i = 0; i < list.length; i++) {
        Product a = list[i];
        if (a.route == route) {
         route2 = list[i-1].route;
        }
      }
      await upOnlyPost(route, route2);
      getItemsfromServ();
    }catch(e){print(e);}
  }
  void tapAdd()async{
    print("Body 65 ADD");

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage()));
   getItemsfromServ();
  }


  @override
  void dispose() {
    controllerScroll.dispose();
    super.dispose();
  }


  @override
  void initState() {
    getItemsfromServ();
    controllerScroll.addListener(() {

      //print("listen scroll ${controllerScroll.position.pixels} // ${controllerScroll.position.maxScrollExtent}");
      // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      // if(controllerScroll.position.pixels > controllerScroll.position.maxScrollExtent){
      //   print(controllerScroll.position.pixels);
      //   getItemsfromServ();
      // }
    });

  }




  @override
  Widget build(BuildContext context) {
    super.build(context);

    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: cBG,
      child: loading?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        controller: controllerScroll,
        child: Container(
          color: cBG,
          child: Column(
            children: [
              gen()
            ],
          ),
        ),
      ),
    );
  }

  Widget gen (){
    print("Body geenrate ${leftColumn.length} , ${rightColumn.length}");
    if(leftColumn.length > 0 || rightColumn.length  >0){
      return  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length,
                        (index) => ItemGetter(
                            leftColumn[index],
                            context, minusFontsSize,
                            minusIconsSize,
                            edit: true,
                            add: (index == 0&&widget.edit)? true:false,
                            tapAdd: ()async{


                              await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: false,)));
                              print("Body 138 ADD");

                              getItemsfromServ();
                            },
                            tapDelete: tapDelete,
                            tapEdit: (route){
                              print("Body 145 ADD");
                              tapEdit(route);
                              //await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: true,id: route,)));
                              //getItemsfromServ();
                            },
                            tapUpFull: (route){tapUpFull(route);},
                          tapUpOnly: (route){tapUpOnly(route);},
                        ),) ,
              ),
              rightColumn.length == 0?SizedBox():Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: List.generate(rightColumn.length,
                        (index) => ItemGetter(
                          rightColumn[index],
                          context,

                          minusFontsSize,
                          minusIconsSize,
                          tapAdd: ()async{
                            print("Body 165 ADD");

                            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: false,)));
                            getItemsfromServ();
                          },
                          tapDelete: tapDelete,
                            tapEdit: (route){
                              print("Body 172 ADD");
                              tapEdit(route);

                              //await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: true,id: route,)));
                              //getItemsfromServ();
                            },
                          tapUpFull: (route){tapUpFull(route);},
                          tapUpOnly: (route){tapUpOnly(route);},
                          edit: true,
                        ),) ,
              ),
            ],
          ),
          SizedBox(height: 50,),
        ],
      );
    }else return Center(
      child: Text("Скоро будут товары :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),),
    );
  }


  @override
  bool get wantKeepAlive => SaveStateCatalog;


}
