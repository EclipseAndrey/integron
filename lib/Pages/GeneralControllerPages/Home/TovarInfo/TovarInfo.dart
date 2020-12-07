import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/My/Buisness/Buisness.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Purchase.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/DB/Products/Property.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/AddProductInCart.dart';
import 'package:omega_qick/Utils/fun/BottomDialogs/BottomSheetSelectParam.dart';
import 'package:omega_qick/main.dart';

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
    item = await ProductProvider.getProduct(widget.id);

    if (item.error == null) {
      print(item.toJson());
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

    return Scaffold(
      backgroundColor: cBG,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.1,
        title: Text(
          title,
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
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Cart(context)));
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
          builder: (context, state) => Content1(context),
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
              height: MediaQuery.of(context).size.width * 0.15,
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
          Opacity(
            opacity: opacity,
            child: Container(
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
                    children: [
                      getIconSvg(
                        id: 15,
                        color: c6287A1,
                        size: 24 - minusIconsSize,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "В избранное",
                        style: TextStyle(color: c5894bc),
                      )
                    ],
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
              height: MediaQuery.of(context).size.width * 0.15,
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
                        item.params.length == 0
                            ? AddProductInCart(context, item.route,
                                product: item)
                            : ShowBottoomSheetSelectParams(
                                context: context,
                                formalize: false,
                                indexSelect: (index) {},
                                product: item);
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
                                context: context,
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
                )
              ],
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
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 8),
              child: price(),
            ),
          ],
        ),
      );
    }


    return Content(context);
  }
}
