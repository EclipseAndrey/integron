import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/BotomSheetEditInformatin.dart';
import 'package:omega_qick/Utils/fun/DialogIntegron.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';

class FormalizePage extends StatefulWidget {
  List<Product> list;

  FormalizePage(this.list);

  @override
  _FormalizePageState createState() => _FormalizePageState();
}

class _FormalizePageState extends State<FormalizePage> {
  bool loadDelivery = true;
  bool information = false;
  double paddingAll = 18;
  String name;
  String address;
  String num;
  String image;

  TextStyle styleLeftColumn = TextStyle(
      color: cMainText,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      fontSize: 14);

  TextEditingController controllerMess = TextEditingController();

  List<Product> list = [];
  int countProduct = 0;
  List<List<Product>> sortList = [];

  load() {
    list = widget.list;
    countProduct = widget.list.length;
    sortList = [];
    for (int i = 0; i < countProduct; i++) {
      print("sort $i");
      bool find = false;
      for (int j = 0; j < sortList.length; j++) {
        print("${sortList[j][0].ownerName} ${list[i].ownerName}");

        if (sortList[j][0].ownerName == list[i].ownerName) {
          sortList[j].add(list[i]);
          find = true;
        }
      }
      if (!find) {
        sortList.add([list[i]]);
      }
    }
    widget.list = list;

    // ignore: unnecessary_statements
    for(int i = 0; i < list.length && information != true;i++) int.parse(list[i].delivery)==1?information=true:null;


    // ignore: unnecessary_statements
    information?LoadDelivery():null;

    setState(() {});
  }


  // ignore: non_constant_identifier_names
  LoadDelivery()async{
    String token = await tokenDB()??"null";
    var a = await checkToken("MHRowJge1fNkDsGC3vmzAc4Yx");
    address = a.address;
    name = a.name;
    num = "+"+a.num;
    image = a.photo;

    loadDelivery = false;
    setState(() {

    });

  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromRGBO(42, 59, 83, 0.1),
          elevation: 30,
          centerTitle: true,
          title: Text(
            "Подтверждение заказа",
            style: TextStyle(
                color: cMainText,
                fontSize: 16,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: GestureDetector(
                onTap: (){closeDialog(context);},
                child: Container(child: getIconForId(id: 0, color: c6287A1))),
          ),
          backgroundColor: cBG,
        ),
        body: Content());
  }

  Widget Content() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: cBackgroundGradient)),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InformationForDelivery(),
                          GenerateProductForFormalize(),
                          Form(),
                          SizedBox(
                        height: 100+paddingAll,
                      )
                    ],
                  )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InformationForDelivery(){
    return !information?SizedBox():Padding(
      padding:  EdgeInsets.all(paddingAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: paddingAll),
            child: Text("Информация для доставки", style: TextStyle( color: cMainText, fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, ),),
          ),
          GestureDetector(
            onTap: (){
              ShowBottomSheetEditInformation(context: context, whereSave:
                  (res)async{
                if(num!=res){
                  await LoadDelivery();
                  num = res;
                }
                return null;
                },
                  name: name,address: address,num: num);
            },
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: cForms,
                borderRadius: BorderRadius.circular(6),
              ),
              duration: Duration(milliseconds: 200),
              child: loadDelivery?SizedBox():Padding(
                padding:  EdgeInsets.all(paddingAll),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: cWhite,
                          radius: 25,
                          child: image != null?Image.network(image):Center(child: Text(name[0], style: TextStyle(fontSize: 25, fontFamily: fontFamily, color: cMainText),),),),
                        ],
                    ),
                    SizedBox(width: paddingAll,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - paddingAll*5-50,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name??"Имя",style: TextStyle(color: name == null?cLinks:cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal,fontSize: 16, fontWeight: FontWeight.w400,),),
                              getIconForId(id: 39, color: cIcons, size: 24,)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: paddingAll/3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(num, style: TextStyle(color: cPlaceHolder, fontWeight: FontWeight.w400, fontSize: 14,fontStyle: FontStyle.normal,fontFamily: fontFamily),)
                          ],
                        ),
                        SizedBox(height: paddingAll/3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - paddingAll*6-50,
                              child: Text(address??"Укажите адрес", style: TextStyle(color: address == null?cLinks:cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400,fontSize: 14, fontFamily: fontFamily),),
                            )
                          ],
                        ),
                        SizedBox(height: paddingAll/3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          ],
                        ),
                        SizedBox(height: paddingAll/3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Изменить",style: TextStyle(color: cLinks, fontWeight: FontWeight.w400, fontSize: 14,fontStyle: FontStyle.normal,fontFamily: fontFamily),)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget GenerateProductForFormalize() {
    Widget itemFormalize(Product item) {
      return Container(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: paddingAll),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingAll,),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  width: 84,
                                  height: 84,
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.cover,
                                  ))),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: paddingAll,
                            ),
                            Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily),
                            )
                          ],
                        ),
                        SizedBox(height: paddingAll,),
                        Padding(
                          padding:  EdgeInsets.only(left: paddingAll),
                          child: item.params.length==0?SizedBox():Container(
                            width: MediaQuery.of(context).size.width - 84 - paddingAll*4,
                            child: Wrap(
                              children:
                                List.generate(item.params.length, (index) => Padding(
                                  padding:  EdgeInsets.only(right: paddingAll, bottom: paddingAll/2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //border: item.params[index].select?Border.all(color: c8dcde0):null,
                                      color: cForms,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      child: Text(item.params[index].params[item.params[index].select].name, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                ),)
                              ,
                            ),
                          ),
                        ),
                      ],

                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingAll,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 84,
                    child: Text(
                      "Цена:",
                      style: styleLeftColumn,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: paddingAll,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.price.toString() + " DEL",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: paddingAll,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 84,
                    child: Text(
                      "Кол-во:",
                      style: styleLeftColumn,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: paddingAll,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){

                          for(int i = 0; i < widget.list.length; i++){
                            if(widget.list[i].route == item.route)item.counter--;
                          }
                          load();
                          if(item.counter==0){
                            for(int i = 0; i < widget.list.length; i++){
                              if(widget.list[i].route == item.route)widget.list.removeAt(i);
                            }
                            load();
                          }



                          setState(() {

                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6)),
                            border: Border.all(color: cd1d3d7, width: 1),
                            color: cForms,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            child: Text(
                              "-",
                              style: TextStyle(
                                color: cMainText,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: cd1d3d7, width: 1),
                          color: cWhite,
                        ),
                        child: ConstrainedBox(

                          constraints: BoxConstraints(minWidth: 50),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            child: Center(
                              child: Text(
                                (item.counter).toString(),
                                style: TextStyle(
                                  color: cMainText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){



                            for(int i = 0; i < widget.list.length; i++){
                              if(widget.list[i].route == item.route)item.counter++;
                            }
                            load();

                          setState(() {

                          });

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: cd1d3d7, width: 1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                            color: cForms,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: cMainText,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "  / ${item.unit}",
                        style: TextStyle(
                          color: cMainText,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: paddingAll,),
             // Divider(color: cDefault.withOpacity(0.3),)
            ],
          ),
        ),
      );
    }

    print(sortList.length);
    return Column(
      children: List.generate(
          sortList.length,
          (indexAll) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: paddingAll*2, left: paddingAll),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sortList[indexAll][0].ownerName,
                                style: TextStyle(
                                    color: cMainText,
                                    fontSize: 16,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w600),
                              ),
                              getIconForId(id: 39, color: c6287A1, size: 24)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          color: cDefault,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: List.generate(sortList[indexAll].length,
                        (index) => itemFormalize(sortList[indexAll][index])),
                  ),
                ],
              )),
    );
  }

  Widget BottomPanel() {
    String getSumm() {
      int s = 0;
      for (int i = 0; i < widget.list.length; i++) {
        s += widget.list[i].price * widget.list[i].counter;
      }
      return s.toString();
    }

    Widget total() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(right: paddingAll),
            child: Container(
              width: 84,
              child: Text(
                'Итого: ',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: cMainText,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 16),
              ),
            ),
          ),
          Text(
            getSumm(),
            style: TextStyle(
                color: Color.fromRGBO(45, 156, 219, 1),
                fontWeight: FontWeight.w600,
                fontFamily: fontFamily,
                fontSize: 16),
          ),
          Text(
            ' DEL',
            style: TextStyle(
                color: cMainText,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamily,
                fontSize: 16),
          ),
        ],
      );
    }

    Widget buttonPay() {
      return GestureDetector(
        onTap: (){
          if(information && (name == null|| address == null)){
            showDialogIntegron(context: context, title: Image.asset("lib/assets/images/dialog-no.png", fit: BoxFit.fill,), body: Text("Информация для доставки не заполнена", style: TextStyle(color: cMainText, fontFamily: fontFamily,fontSize: 16,fontWeight: FontWeight.w400),));
          }else{
            showDialogIntegron(context: context, title: Image.asset("lib/assets/images/dialog-no.png", fit: BoxFit.fill,), body: Text("Оплата не прошла", style: TextStyle(color: cMainText, fontFamily: fontFamily,fontSize: 16,fontWeight: FontWeight.w400),));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: cPay,
            borderRadius: BorderRadius.circular(6),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width - paddingAll * 2,
          child: Center(
            child: Text(
              "Оплатить",
              style: TextStyle(
                  color: cWhite,
                  fontSize: 16,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: cDefault.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 30,
          offset: Offset(0, -30), // changes position of shadow
        ),
      ], color: cWhite),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingAll),
            child: total(),
          ),
          buttonPay(),
        ],
      ),
    );
  }

  Widget Form() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: paddingAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 84,
                child: Text(
                  "Условия доставки:",
                  style: styleLeftColumn,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: paddingAll,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 84 - paddingAll * 4,
                child: Text(
                  "Определяется условиями магазина",
                  style: styleLeftColumn,
                ),
              ),
            ],
          ),
          SizedBox(
            height: paddingAll,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 84,
                child: Text(
                  "Сообщение магазину:",
                  style: styleLeftColumn,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: paddingAll,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: cd1d3d7, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: MediaQuery.of(context).size.width - 84 - paddingAll * 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      autofocus: false,

                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        //hint
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: fontFamily,
                          fontStyle: FontStyle.normal,
                          color: cPlaceHolder,
                        ),
                        hintText: "Текст сообщения",
                      ),

                      //text
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily,
                        fontStyle: FontStyle.normal,
                        color: cMainText,
                      ),
                      controller: controllerMess,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
