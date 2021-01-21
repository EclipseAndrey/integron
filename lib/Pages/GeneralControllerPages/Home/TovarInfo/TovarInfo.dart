import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/Buisness/Buisness.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Purchase.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Products/Property.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/AddProductInCart.dart';
import 'package:integron/Utils/fun/BottomDialogs/BottomSheetSelectParam.dart';
import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:integron/Utils/fun/Logs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:integron/main.dart';
import 'package:flutter/services.dart';

class TovarInfo extends StatefulWidget {
  int id;

  TovarInfo(this.id);

  @override
  _TovarInfoState createState() => _TovarInfoState();
}

class _TovarInfoState extends State<TovarInfo> {
  double minusIconsSize = 0;
  double minusFontsSize = 0;


  bool isFavorite = false;

  PageController controllerImageSlider = PageController();

  Product item;
  String title = "Загрузка";

  List<Widget> imagePages = [];
  bool loading = true;

  void load() async {
    item = await ProductProvider.getProduct(widget.id);

    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++prodeuctInfo     "+(item.errors == null).toString()+(item.errors.mess));
    if (item.errors == null) {
      isFavorite = item.isFavorite;
      //print(item.toJson());
      imagePages = List.generate(
          item.images.length,
          (index) => Image.network(
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle//.dark
        (
        //statusBarColor: cBackground,
        systemNavigationBarColor: Color(0x00cccccc),
        systemNavigationBarDividerColor: Color(0x00cccccc),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFffffff),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < 400) {
      minusIconsSize = minusIconsSizeHome400 + 6;
      minusFontsSize = minusFontsSizeHome400 + 2;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: cBG,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          title: Text(
            !(((item != null) && (item.errors != null))&&loading)?title:"Ошибка",
            style: TextStyle(
                color: cMainText.withOpacity(0.7),
                fontSize: 24,
                fontFamily: fontFamily),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: getIconSvg(
                  id: 0,
                  color: c5894bc,
                ),
              )),
          backgroundColor: cBG,
          actions: [
            !FullVersion?SizedBox():GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Cart(context, true)));
                },
                child: getIconSvg(
                  id: 55,
                  color: c5894bc,
                )),
            SizedBox(
              width: 12,
            ),
            // getIconForId(id: 15, color: c5894bc,),
            // SizedBox(width: 12,),
            //
            // getIconForId(id: 25, color: c5894bc,),
            // SizedBox(width: 12,),
          ],
        ),
        body: BlocProvider<CartCubit>(
          create: (BuildContext) => CartCubit(),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) => ((item != null) && (item.errors != null))?Center(child:  Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(item.errors.mess),
            ),):Content1(context),
          ),
        ),
      ),
    );
  }

  Widget Content1(BuildContext context) {


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
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controllerImageSlider.positions.length == 0
                                    ? "1 / ${imagePages.length}"
                                    : "${controllerImageSlider.page.round() + 1} / ${imagePages.length}",
                                style: TextStyle(
                                    color: cMainText,
                                    fontSize: 14,
                                    fontFamily: fontFamily),
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
      Widget textcat(Category cat) {
        return Text(
          cat.name,
          style: TextStyle(
              color: c5894bc,
              fontFamily: fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(item.catPath.length, (index) {
          Category step = item.catPath[0];

          if (index == item.catPath.length - 1) {
            return textcat(step);
          } else {
            return Row(
              children: [
                textcat(step),
                Text(
                  " / ",
                  style: TextStyle(
                      color: cMainText,
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            );
          }
        }),
      );
    }

    Widget nameProduct() {
      return Text(
        item.name,
        style: TextStyle(
            color: cMainText,
            fontSize: 24,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal),
      );
    }

    Widget panelInfoProduct() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BusinessPage.read(item.owner)));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 245, 239, 1),
                  borderRadius: BorderRadius.circular(6)),
              width: MediaQuery.of(context).size.width * 0.30,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.width * 0.15
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getIconSvg(
                          id: 44,
                          color: c6287A1,
                          size: 24 - minusIconsSize,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "В магазин",
                          style: TextStyle(color: c5894bc),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 1,
            child: GestureDetector(
              onTap: ()async{
                isFavorite = !isFavorite;
                setState(() {});
                Put response = await ProductProvider.setFavorite(item.route, isFavorite);
                if(response.error == 200){
                  if(isFavorite){
                    showDialogIntegron(context: context, title: Image.asset('lib/assets/images/add-favorite.png',), body: Text('Товар добавлен в избранное!', textAlign: TextAlign.center, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,fontFamily: fontFamily),));
                  }else{
                    //delete favorite
                  }
                }else{
                  //todo error add / delete
                }
                load();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 245, 239, 1),
                    borderRadius: BorderRadius.circular(6)),
                width: MediaQuery.of(context).size.width * 0.30,
                // height: MediaQuery.of(context).size.width * 0.15,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.width * 0.15
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getIconSvg(
                            id: !isFavorite?IconsSvg.favorites:IconsSvg.favoritesSmInactive,
                            color: c6287A1,
                            size: 24 - minusIconsSize,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Избранное",
                            style: TextStyle(color: c5894bc),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 245, 239, 1),
                  borderRadius: BorderRadius.circular(6)),
              width: MediaQuery.of(context).size.width * 0.30,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.width * 0.15
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getIconSvg(
                          id: 43,
                          color: c6287A1,
                          size: 24 - minusIconsSize,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Поделиться",
                          style: TextStyle(color: c5894bc),
                        )
                      ],
                    ),
                  ),
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
          Divider(
            color: cDefault,
          ),
          Text(
            name,
            style: TextStyle(
                color: c2f527f,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: fontFamily),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(
                color: cMainText,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamily),
          ),
        ],
      );
    }

    Widget constructorProperty() {
      return Column(
        children: List.generate(item.property.length, (index) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.price.toString(),
                        style: TextStyle(
                            color: c5894bc,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            fontFamily: fontFamily),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Row(
                          children: [
                            Text(
                              " DEL ",
                              style: TextStyle(
                                  color: c5894bc,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: fontFamily),
                            ),
                            Text(
                              "(~${item.price * course}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily),
                            ),
                            Text(
                              " ₽",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              ")/${item.unit}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontFamily),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AddProductInCart(context, item.route,
                                      product: item);
                          // item.params.length == 0
                          //     ? AddProductInCart(context, item.route,
                          //         product: item)
                          //     : ShowBottoomSheetSelectParams(
                          //         context: context,
                          //         formalize: false,
                          //         indexSelect: (index) {},
                          //         product: item);
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
                                Text(
                                  "В корзину",
                                  style: TextStyle(
                                      color: c2f527f,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartCubit>(context).load();
                          // ignore: unnecessary_statements
                          item.params.length == 0
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context1) =>
                                          FormalizePage([item], context)))
                              : ShowBottoomSheetSelectParams(
                                  contextBloc: context,
                                  formalize: true,
                                  indexSelect: (index) {},
                                  product: item);
                        },
                        child: Container(
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
                                Text(
                                  "Купить сейчас",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget Content(BuildContext context) {
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
                        SizedBox(
                          height: 6,
                        ),

                        nameProduct(),
                        SizedBox(
                          height: 12,
                        ),

                        panelInfoProduct(),
                        SizedBox(
                          height: 8,
                        ),
                        textProduct("Описание", item.fullText),
                        // textProduct("Доставка",int.parse(item.delivery) == 1?"Есть":"Нет"),
                        constructorProperty(),
                        linkWidget(),


                      ],
                    ),
                  ),
                  details(),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            !FullVersion?SizedBox():Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 0.0, vertical: 0),
              child: price(),
            ),
          ],
        ),
      );
    }


    return Content(context);
  }
  Widget linkWidget(){
    Widget head = Text(
      "Ссылка на тренинг",
      style: TextStyle(
          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
    return item.link == null || item.link == ""?SizedBox():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: cDefault),
        head,
        SizedBox(
          height:6,
        ),
        InkWell(
          onTap: ()async{
            //todo
            if (await canLaunch(item.link)) {
            await launch(item.link);
            } else {
            printL("Could not launch ${item.link}");
            }
          },
          child: Text("Перейти", style: TextStyle(
              color: c2f527f, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        )
      ],
    );
  }


  Widget details(){
    Widget head = Text(
      "Детали",
      style: TextStyle(
          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
    return Column(
      children: [
        Divider(color: cDefault),
        item.details.length == 0?SizedBox():Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              head,
            ],
          ),
        ),
        Column(
          children: item.details.length == 0?[]:List.generate(item.details.length, (index){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.network(
                item.details[index],
                fit: BoxFit.cover,
              ),
            );
          }),
        )

      ],
    );
  }
}
