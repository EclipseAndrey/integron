import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/Buisness/Buisness.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Purchase.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/ImagesProduct.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Products/Property.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/AddProductInCart.dart';
import 'package:integron/Utils/fun/BottomDialogs/BottomSheetSelectParam.dart';
import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';

import 'package:integron/main.dart';
import 'package:flutter/services.dart';

class ViewProductPage extends StatefulWidget {
  List<ImageProduct> images;
  List<ImageProduct> imagesD;

  Product  product;

  ViewProductPage(this.product, this.images, this.imagesD);

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  double minusIconsSize = 0;
  double minusFontsSize = 0;


  bool isFavorite = false;

  PageController controllerImageSlider = PageController();

  // Product item = widget.product;
  String title = "Просмотр";

  List<Widget> imagePages = [];
  List<Widget> detailsPages = [];
  bool loading = false;



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

    imagePages = List.generate(
        widget.images.length,
            (index) =>  widget.images[index].net?Image.network(
              widget.images[index].path,
          fit: BoxFit.cover,
        ):Image.asset(
              widget.images[index].path,
              fit: BoxFit.cover));

    detailsPages = List.generate(
        widget.imagesD.length,
            (index) =>  widget.imagesD[index].net?Image.network(
          widget.imagesD[index].path,
          fit: BoxFit.cover,
        ):Image.asset(
            widget.imagesD[index].path,
            fit: BoxFit.cover));


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
            title,
            style: TextStyle(
                color: cMainText.withOpacity(0.7),
                fontSize: 24,
                fontFamily: fontFamily),
          ),
          // leading: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(19.0),
          //       child: getIconSvg(
          //         id: 0,
          //         color: c5894bc,
          //       ),
          //     )),
          backgroundColor: cBG,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: getIconSvg(
                  id: IconsSvg.eyeClosed,
                  color: c5894bc,
                )),
            SizedBox(
              width: 12,
            ),
          ],
        ),
        body: Content1(context),
      ),
    );
  }

  Widget Content1(BuildContext context) {


    Widget ImageSlider() {
      controllerImageSlider.addListener(() {
        setState(() {});
      });
      print("images "+widget.product.images.length.toString());
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
        children: List.generate(widget.product.catPath.length, (index) {
          Category step = widget.product.catPath[0];

          if (index == widget.product.catPath.length - 1) {
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
        widget.product.name,
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
            onTap: () {},
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
            opacity: 1,
            child: GestureDetector(
              onTap: ()async{
                isFavorite = !isFavorite;
                setState(() {});
                // Put response = await ProductProvider.setFavorite(widget.product.route, isFavorite);
                // if(response.error == 200){
                //   if(isFavorite){
                //     showDialogIntegron(context: context, title: Image.asset('lib/assets/images/add-favorite.png',), body: Text('Товар добавлен в избранное!', textAlign: TextAlign.center, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,fontFamily: fontFamily),));
                //   }else{
                //     //delete favorite
                //   }
                // }else{
                //   //todo error add / delete
                // }
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
                          id: !isFavorite?IconsSvg.favorites:IconsSvg.favoritesSmInactive,
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
        children: List.generate(widget.product.property.length, (index) {
          Property property = widget.product.property[index];
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
                        widget.product.price.toString(),
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
                              "(~${widget.product.price * course}",
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
                              ")/${widget.product.unit}",
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
                          // AddProductInCart(context, widget.product.route,
                          //     product: widget.product);
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
                          // BlocProvider.of<CartCubit>(context).load();
                          // ignore: unnecessary_statements
                          // widget.product.params.length == 0
                          //     ? Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context1) =>
                          //             FormalizePage([widget.product], context)))
                          //     : ShowBottoomSheetSelectParams(
                          //     contextBloc: context,
                          //     formalize: true,
                          //     indexSelect: (index) {},
                          //     product: widget.product);
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
          : widget.product.error != null
          ? Center(
        child: Text("Код закгрузки ${widget.product.error}\nПопробуйте позже"),
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
                        textProduct("Описание", widget.product.fullText),
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
    return widget.product.link == null || widget.product.link == ""?SizedBox():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: cDefault),
        head,
        SizedBox(
          height:6,
        ),
        Text("Перейти", style: TextStyle(
            color: c2f527f, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: fontFamily),)
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
        widget.imagesD.length == 0?SizedBox():Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              head,
            ],
          ),
        ),
        Column(
          children: widget.imagesD.length == 0?[]:List.generate(widget.imagesD.length, (index){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: detailsPages[index],
            );
          }),
        )

      ],
    );
  }
}
