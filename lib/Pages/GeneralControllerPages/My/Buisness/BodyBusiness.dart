import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/PageAddProduct.dart';
import 'package:integron/Providers/BizProvider/BizProvider.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/REST/Autorization/checkToken.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:integron/Utils/fun/DialogIntegron.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';

class BodyBusiness extends StatefulWidget {

  bool edit;
  int type;
  int id;
  BodyBusiness({this.type, this.edit,this.id});

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
    var biz;
    if(widget.edit) {
      InfoToken infoToken = await checkToken();
      biz= await BizProvider.getBusiness(infoToken.id);
    }else{
      biz= await BizProvider.getBusiness(widget.id);
    }
    list = biz.products;
    print("body loading ${list.length} элементов при инициализации в list");
    print("body loading ${listStep.length} элементов при инициализации в listStep");


    for(int i =0; i < list.length; i++){
     // Product pSortStep = list[i] as Product;
      listStep.add(list[i]);
    }
    // for(int i =0; i < list.length; i++){
    //     Product pSortStep = list[i] as Product;
    //     // try {
    //       print("type Body ${list[i]==null}  ${ widget.type}");
    //
    //       if ((list[i] == null ?0: (list[i].type == null?0:list[i].type)) == widget.type)
    //         listStep.add(list[i]);
    //     // }catch(e){print(e);}
    // }
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
  dialogErr(String text)async{
    await showDialogIntegron(context: context,
        title: Text("Сообщение",  style: TextStyle(color: cMainText, fontSize: 16,fontFamily: fontFamily),),
        body: Text(text,
          style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
          textAlign: TextAlign.center, ));
  }
  //todo
  tapDelete(int route)async{
    print("tap delete");
    showDialogLoading(context);
    var a =await ProductProvider.forBiz.deleteItem(route);
    closeDialog(context);
    if(a.error == 200){
      dialogErr("Успешно удалено");
      getItemsfromServ();

    }else{
      dialogErr("Не удалось удалить\nКод ${a.error}\nСообщите разрабочикам, если ошибка повторяется");
      getItemsfromServ();

    }

  }
  tapEdit(int route)async{
    print("Body 56 ADD");
    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: true,id: route,)));
    getItemsfromServ();
  }
  //todo
  tapUpFull(int route)async{
    print("tapUpFull");
    await ProductProvider.forBiz.upFull(route);
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
      await ProductProvider.forBiz.upOnly(route, route2);
      getItemsfromServ();
    }catch(e){print(e);}
  }
  void tapAdd()async{
    print("Body 65 ADD");

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage()));
    getItemsfromServ();
  }

  tapHidden(int route, int hidden)async{
    print("tap hidden");
    showDialogLoading(context);
    var a =await ProductProvider.forBiz.hiddenItem(route, hidden == 0?1:0);
    closeDialog(context);
    if(a.error == 200){
      // dialogErr("Успешно скрыто/показано");
      getItemsfromServ();

    }else{
      dialogErr("Не удалось скрыть/показать \nКод ${a.error}\nСообщите разрабочикам, если ошибка повторяется");
      getItemsfromServ();

    }

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


  double c = 12;
  double edge = 18;
  double h2= 0;
  double h1= 0;
  double h0= 0;
  double w =0;
  double p =0;




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

    w =  MediaQuery.of(context).size.width/2 - c/2 - edge;
    h2  = w*1.50;
    h1  = w*0.72;
    h0  = w*0.33;


    print("Body geenrate ${leftColumn.length} , ${rightColumn.length}");
    if(leftColumn.length > 0 || rightColumn.length  >0){
      return  Column(
        children: [
          SizedBox(height: c,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: edge,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length,
                        (index) => Column(
                          children: [
                            ItemGetter(
                              leftColumn[index],
                              context, minusFontsSize,
                              minusIconsSize,
                              edit: widget.edit,
                              add: (index == 0&&widget.edit)? true:false,
                              tapAdd: ()async{
                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: false,)));
                                  getItemsfromServ();
                                  },
                              tapDelete:(r){ tapDelete(r);},
                              tapEdit: (route){tapEdit(route);},
                              tapUpFull: (route){tapUpFull(route);},
                              tapUpOnly: (route){tapUpOnly(route);},
                              tapHidden: (route, hidden){tapHidden(route, hidden);},
                            ),
                            SizedBox(height: c,),

                          ],
                        ),) ,
              ),
              SizedBox(width: c,),
              rightColumn.length == 0?SizedBox():Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(rightColumn.length,
                      (index) => Column(
                        children: [
                          ItemGetter(
                            rightColumn[index],
                            context,
                            minusFontsSize,
                            minusIconsSize,
                            tapAdd: ()async{
                                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(edit: false,)));
                                getItemsfromServ();
                              },
                            tapDelete:(r){ tapDelete(r);},
                            tapEdit: (route){tapEdit(route);},
                            tapUpFull: (route){tapUpFull(route);},
                            tapUpOnly: (route){tapUpOnly(route);},
                            tapHidden: (route, hidden){tapHidden(route, hidden);},
                            edit: widget.edit,
                          ),
                          SizedBox(height: c,),

                        ],
                      ),
                ) ,
              ),
              SizedBox(width: edge,),

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
