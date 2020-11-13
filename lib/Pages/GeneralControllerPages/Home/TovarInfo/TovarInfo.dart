import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/CategoryPath.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/Items/Property.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/main.dart';
import '../Settings.dart';

class TovarInfo extends StatefulWidget {
  int id;

  TovarInfo(this.id);

  @override
  _TovarInfoState createState() => _TovarInfoState();
}

class _TovarInfoState extends State<TovarInfo> {

  double minusIconsSize = 0;
  double minusFontsSize = 0;

  PageController controllerImageSlider = PageController();

  Product item;
  String title = "Загрузка";

  List<Widget> imagePages = [];
  bool loading = true;

  void load() async {
    item = await getProductForId(widget.id);

    if (item.error == null) {
    imagePages = List.generate(
        item.images.length,
            (index) =>
            Image.network(
              item.images[index],
              fit: BoxFit.cover,
            ));
    title = item.name;
  }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      minusIconsSize = minusIconsSizeHome400 + 6;
      minusFontsSize = minusFontsSizeHome400 + 2;
    }

    return Scaffold(
      backgroundColor: cBG,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.1,
        title: Text(title, style: TextStyle(color: cMainText.withOpacity(0.7), fontSize: 24, fontFamily: fontFamily),),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: c5894bc,)),
        backgroundColor: cBG,
        actions: [
          getIconForId(id: 55, color: c5894bc,),
          SizedBox(width: 12,),
          getIconForId(id: 15, color: c5894bc,),
          SizedBox(width: 12,),

          getIconForId(id: 25, color: c5894bc,),
          SizedBox(width: 12,),

        ],
      ),
      body: Content(),
    );
  }

  Widget Content() {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : item.error != null
            ? Center(
                child: Text("Код закгрузки ${item.error}\nПопробуйте позже"),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ImageSlider(),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                category(),
                                SizedBox(height: 6,),

                                nameProduct(),
                                SizedBox(height: 12,),

                                panelInfoProduct(),
                                SizedBox(height: 8,),
                                textProduct("Описание",item.fullText),
                                textProduct("Доставка",item.delivery),
                                constructorProperty(),
                                SizedBox(height: 100,),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: price(),
                    ),
                  ],
                ),
              );
  }

  Widget ImageSlider() {
    controllerImageSlider.addListener(() {
      setState(() {});
    });
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: imagePages.length == 0
          ? Center(
              child: Icon(Icons.broken_image),
            )
          : Stack(
              children: [
                PageView(
                  children: imagePages,
                  controller: controllerImageSlider,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: imagePages.length == 0
                                ? Colors.transparent
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controllerImageSlider.positions.length == 0
                                  ? "1 / ${imagePages.length}"
                                  : "${controllerImageSlider.page.round() + 1} / ${imagePages.length}",
                              style:
                                  TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget category() {

    Widget textcat(CategoryPath cat){
      return Text(cat.name, style: TextStyle(color:c5894bc, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal ),);
    }


    return Row(mainAxisAlignment: MainAxisAlignment.start,
    children: List.generate(item.catPath.length, (index) {
      CategoryPath step = item.catPath[index];

      if(index == item.catPath.length-1){
        return textcat(step);
      }else{
        return Row(
          children: [
            textcat(step),
            Text(" / ", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400),),
          ],
        );
      }
    }),
    );
  }

  Widget nameProduct() {
    return Text(item.name, style: TextStyle(color: cMainText, fontSize:  24, fontFamily:  fontFamily, fontWeight:  FontWeight.w400, fontStyle:  FontStyle.normal),);
  }

  Widget panelInfoProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(

          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 245, 239, 1),
              borderRadius: BorderRadius.circular(6)),
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.width * 0.15,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [getIconForId(id:44, color: c6287A1,size: 24- minusIconsSize,), SizedBox(height: 6,),Text("В магазин", style: TextStyle(color: c5894bc),)],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 245, 239, 1),
              borderRadius: BorderRadius.circular(6)),
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.width * 0.15,

          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [getIconForId(id:15, color: c6287A1,size: 24 - minusIconsSize,),SizedBox(height: 6,), Text("В избранное", style: TextStyle(color: c5894bc),)],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 245, 239, 1),
              borderRadius: BorderRadius.circular(6)),
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.width * 0.15,

          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [getIconForId(id:43, color: c6287A1,size: 24- minusIconsSize,), SizedBox(height: 6,), Text("Поделиться", style: TextStyle(color: c5894bc),)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textProduct(String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: cDefault,),
        Text(
          name,
          style: TextStyle(
              color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
        ),
        SizedBox(height:  4,),
        Text(
          value,
          style: TextStyle(
              color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
        ),
      ],
    );
  }

  Widget constructorProperty(){
    return Column(
      children: List.generate(item.property.length, (index){
        Property property = item.property[index];
        return textProduct(property.name, property.value);
      }),
    );
  }


  Widget price() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,

      children: [
        Container(
          color: cBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(item.price.toString(), style: TextStyle(color: c5894bc, fontSize: 27, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      children: [
                        Text(" DEL ",  style: TextStyle(color: c5894bc, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                        Text("(~${item.price * course}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                        Text(" ₽", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400,),),
                        Text(")/${item.unit}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      print("обавлено");

                      bool find = false;
                      for(int i = 0; i < cartList.length; i++){
                        if(cartList[i].route == item.route){
                          cartList[i].counter++;
                          find = true;
                        }
                      }
                      if(!find){cartList.add(item);}

                      Fluttertoast.showToast(
                          msg: "Добавлено",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromRGBO(203, 254, 254, 1),
                      ),
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("В корзину", style: TextStyle(color: c2f527f, fontWeight:  FontWeight.w500, fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Купить сейчас",style: TextStyle(color: Colors.white, fontWeight:  FontWeight.w500, fontSize: 16),),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
