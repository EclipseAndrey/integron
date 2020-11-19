import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/Orders/Order.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/main.dart';

class OrdersBizContent extends StatefulWidget {

  Function stateCallback;

  List<Order> orders;

  OrdersBizContent({ this.stateCallback, this.orders});


  @override
  _OrdersBizContentState createState() => _OrdersBizContentState();
}

class _OrdersBizContentState extends State<OrdersBizContent> {

  double paddingAll = 12;




  @override
  void initState() {



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
                Padding(
                  padding:  EdgeInsets.all(paddingAll),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [head()],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height-140,
                  width: MediaQuery.of(context).size.width - paddingAll*2,
                  child: widget.orders.length==0?Center(child: Text("Тут пока пусто :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),),):
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(widget.orders.length, (indexAll) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            getIconForId(id: 44, color: c6287A1, size: 24),
                                            SizedBox(width: paddingAll,),
                                            Text(widget.orders[indexAll].bizName, style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                        getIconForId(id: 39, color: c6287A1, size: 24)
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Divider(color: cDefault,),
                                  ],
                                ),
                              ),
                              Column( children: List.generate(1, (index) => ItemCart(indexAll, index)),),
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
      ],
    );
  }


  Widget ItemCart(int indexAll, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(widget.orders[indexAll].products[0].route)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-paddingAll*2,

        child: Column(
          children: [
            Row(
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
                            child: Image.network(widget.orders[indexAll].products[0].image, height: 84, width: 84, fit: BoxFit.cover,))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.orders[indexAll].products[index].name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: cMainText, fontFamily: fontFamily),),
                      Container(width: MediaQuery.of(context).size.width-paddingAll*2- 108,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.orders[indexAll].paramsString.length==0?SizedBox(height: paddingAll,):Padding(
                              padding:  EdgeInsets.symmetric(vertical: paddingAll),
                              child: Wrap(
                                children:
                                List.generate(widget.orders[indexAll].paramsString.length, (indexC) => Padding(
                                  padding:  EdgeInsets.only(right: paddingAll),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //border: item.params[index].select?Border.all(color: c8dcde0):null,
                                      color: cForms,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      child: Text(widget.orders[indexAll].paramsString[indexC], style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        price(indexAll,index),
                                        unitWidget(index)
                                      ],
                                    ),
                                    countWidget(indexAll),
                                  ],
                                ),
                                // Spacer(),
                                // Row(
                                //   // mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     GestureDetector(
                                //         onTap:(){
                                //           for(int i = 0; i < cartList.length; i++){
                                //             if(cartList[i].route == widget.orders[indexAll].products[index].route)cartList.removeAt(i);
                                //           }
                                //         },
                                //         child: Container(child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: getIconForId(id: 8, color: c6287A1, size: 18),
                                //         ))),
                                //     SizedBox(width: 8,),
                                //     counterSelect(indexAll, index),
                                //   ],
                                // )
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                total(indexAll),
              ],
            ),
            Divider(),
            SizedBox(height: paddingAll,)
          ],
        ),
      ),
    );
  }

  Widget price(int indexAll, int index){
    return Row(
      children: [
        Text(widget.orders[indexAll].products[index].price.toString(), style: TextStyle(color:  Color.fromRGBO(58, 162, 221, 1), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
        Text(" DEL" , style: TextStyle(color:  cMainText, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: fontFamily), ),
      ],
    );
  }

  Widget unit(int indexAll,int index){
    String getRub(){
      return (widget.orders[indexAll].products[index].price*course).toString();
    }
    return Row(
      children: [
        Text("(~",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(getRub(),  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text("₽",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400),),
        Text(") / ",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(widget.orders[indexAll].products[index].unit,  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
      ],
    );
  }

  Widget countWidget(int index){
    return Text(widget.orders[index].count.toString()+" "+widget.orders[index].products[0].unit,  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),);
  }
  Widget unitWidget(int index){
    return Text(" / "+widget.orders[index].products[0].unit,  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),);
  }


  Widget counterSelect(int indexAll,int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, //Color.fromRGBO(240,245,239,1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(widget.orders[indexAll].products[index].counter.toString(), style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 14),),
      ),
    );
  }

  Widget total (int index){
    double tot = widget.orders[index].products[0].price * widget.orders[index].count;
    return Row(
      children: [
        Text("Итого: ", style: TextStyle(color:  cMainText, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(tot.toString(), style: TextStyle(color:  Color.fromRGBO(58, 162, 221, 1), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
        Text(" DEL" , style: TextStyle(color:  cMainText, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: fontFamily), ),
      ],
    );
  }

  Widget head(){
    return Text("Мои заказы", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 24),);
  }

}
