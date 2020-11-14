import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/main.dart';

class ListCartPage extends StatefulWidget {
  bool tovar = false;
  ListCartPage({@required this.tovar});


  @override
  _ListCartPageState createState() => _ListCartPageState();
}

class _ListCartPageState extends State<ListCartPage> {
  int countProduct = 0;
  double paddingAll = 12;

  List<Product> list = [];

  List<List<Product>> sortList = [];


  load(){
    list = [];
    for(int i = 0; i < cartList.length; i++){
      int a = widget.tovar?0:1;
      if(cartList[i].type ==a ){list.add(cartList[i]);}
    }
    countProduct = list.length;
    sortList = [];

    for(int i = 0; i < countProduct; i++){
      print("sort $i");
      bool find = false;
      for(int j = 0; j < sortList.length; j ++){
        print("${sortList[j][0].ownerName} ${list[i].ownerName}");

        if(sortList[j][0].ownerName == list[i].ownerName){
          sortList[j].add(list[i]);
          find = true;
        }

      }
      if(!find){
        sortList.add([list[i]]);
      }
    }
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width - paddingAll*2,
            height: MediaQuery.of(context).size.height-30,
            child: Column(
              children: [
                Container(
                  height: countProduct == 0?0:!widget.tovar?0:50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      counterProducts(),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height-130,
                  width: MediaQuery.of(context).size.width - paddingAll*2,
                  child: list.length==0?Center(child: Text("Тут пусто :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),),):
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(sortList.length, (indexAll) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(sortList[indexAll][0].ownerName, style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w600),),
                                        getIconForId(id: 39, color: c6287A1, size: 24)
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Divider(color: cDefault,),
                                  ],
                                ),
                              ),
                              Column( children: List.generate(sortList[indexAll].length, (index) => ItemCart(indexAll, index)),),
                            ],
                          )),
                        ),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: list.length==0?SizedBox():EndPrice(),
        )
      ],
    );
  }

  EndPrice() {

    String getSumm(){
      int s = 0;
      for(int i = 0; i < list.length; i++){
        s+=list[i].price*list[i].counter;
      }
      return s.toString();
    }

    Widget total() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Итого: ', style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16),),
          Text(getSumm(), style: TextStyle(color: c5894bc, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 16),),
          Text(' DEL', style: TextStyle(color: cMainText, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 16),),
        ],
      );
    }

    Widget buttonPay() {
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FormalizePage(list)));
          },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 0, 0, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: Text("Оформить", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, ),)),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0, left: 12, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: cBG,
            width: MediaQuery.of(context).size.width- paddingAll*2,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  total(),
                  buttonPay(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width- paddingAll*2,
            height: 50,
            color: cBG,
          )
        ],
      ),
    );
  }

  Widget ItemCart(int indexAll, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(sortList[indexAll][index].route)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-paddingAll*2,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingAll,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                        height: 84 ,
                        child: Image.network(sortList[indexAll][index].image, height: 84, width: 84, fit: BoxFit.cover,))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sortList[indexAll][index].name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: cMainText, fontFamily: fontFamily),),
                  Container(width: MediaQuery.of(context).size.width-paddingAll*2- 108,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sortList[indexAll][index].params.length==0?SizedBox(height: paddingAll,):Padding(
                          padding:  EdgeInsets.symmetric(vertical: paddingAll),
                          child: Wrap(
                            children:
                            List.generate(sortList[indexAll][index].params.length, (indexC) => Padding(
                              padding:  EdgeInsets.only(right: paddingAll),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: item.params[index].select?Border.all(color: c8dcde0):null,
                                  color: cForms,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                  child: Text(sortList[indexAll][index].params[indexC].params[sortList[indexAll][index].params[indexC].select].name, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400),),
                                ),
                              ),
                            ),)
                            ,
                          ),
                        ),
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                price(indexAll,index),
                                unit(indexAll, index),
                              ],
                            ),
                            // Spacer(),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      for(int i = 0; i < cartList.length; i++){
                                        if(cartList[i].route == sortList[indexAll][index].route)cartList.removeAt(i);
                                      }
                                      load();

                                    },
                                    child: Container(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: getIconForId(id: 8, color: c6287A1, size: 18),
                                    ))),
                                SizedBox(width: 8,),
                                counterSelect(indexAll, index),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget price(int indexAll, int index){
    return Row(
      children: [
        Text(sortList[indexAll][index].price.toString(), style: TextStyle(color:  c6287A1, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
        Text(" DEL" , style: TextStyle(color:  cMainText, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: fontFamily), ),
      ],
    );
  }

  Widget unit(int indexAll,int index){
    String getRub(){
      return (sortList[indexAll][index].price*course).toString();
    }
    return Row(
      children: [
        Text("(~",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(getRub(),  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text("₽",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400),),
        Text(") / ",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(sortList[indexAll][index].unit,  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
      ],
    );
  }

  Widget counterSelect(int indexAll,int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, //Color.fromRGBO(240,245,239,1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(sortList[indexAll][index].counter.toString(), style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 14),),
      ),
    );
  }



  Widget counterProducts(){
    if(countProduct == 0 || !widget.tovar){
      return SizedBox();
    }else{
      return Text("Итого $countProduct ${widget.tovar?"товаров":"услуг"} в корзине", style: TextStyle(fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.w400, color: Color.fromRGBO(122,139,163,1)),);
    }
  }



}
