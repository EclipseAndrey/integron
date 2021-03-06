import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:integron/REST/Cart/updateCart.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Products/Params/Params.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/fun/AddProductInCart.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:integron/main.dart';

Future<void> ShowBottoomSheetSelectParams(
    {
      @required BuildContext contextBloc,
    @required bool formalize,
    @required ValueChanged<int> indexSelect,
    @required Product product}) async {
  double shortestSide = MediaQuery.of(contextBloc).size.shortestSide;

  bool resize = false;
  if (shortestSide < 400) {
    resize = true;
  }
  print(resize);

  final scrollController = ScrollController(initialScrollOffset: 0);
  // print("===="+product.params[0].params[0].name);

  Widget listPar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product.params.length == 0
          ? SizedBox()
          : List.generate(product.params.length, (index) {
              //print(" -222 "+product.params[index].name);
              bool select = true;
              return ContentSelectParams(
                paramsA: product.params[index],
                indexSelect: (value) {
                  product.params[index].select = value;
                },
              );
            }),
    );
  }

  Widget price() {
    return !resize
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(product.price.toString(), style: TextStyle(color: c5894bc, fontSize: 27, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
              Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Row(
                  children: [
                    Text(" DEL ", style: TextStyle(color: c5894bc, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                Text("(~${product.price * course}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                Text(" ₽", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400,),),
                Text(")/${product.unit}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),)
                  ],
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(product.price.toString(), style: TextStyle(color: c5894bc, fontSize: 27, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(" DEL ", style: TextStyle(color: c5894bc, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                        // Text("(~${product.price * course}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                        // Text(" ₽", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400,),),
                        // Text(")/${product.unit}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                      ],
                    ),
                  )
                ],
              ),
              // Text(product.price.toString(), style: TextStyle(color: c5894bc, fontSize: 27, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
              Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Row(
                  children: [
                    Text("(~${product.price * course}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                    Text(" ₽", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400,),),
                    Text(")/${product.unit}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  showBarModalBottomSheet(
    backgroundColor: cBG,
    context: contextBloc,
    builder: (context, scrollController) {
      return ConstrainedBox(
        // color: cBG,

        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.50,
          minHeight: 200,
        ),
        // height: 400,
        child: Material(
          color: cBG,
          child: Scaffold(
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.50,
                        minHeight: 200,
                        minWidth: MediaQuery.of(context).size.width,
                        maxWidth: MediaQuery.of(context).size.width),
                    child: Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    child: Container(
                                        height: 84,
                                        width: 84,
                                        child: Image.network(
                                          product.image,
                                          fit: BoxFit.cover,
                                        )),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      price(),
                                      Text(
                                        'В наличии',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontFamily: fontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: cMainText),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              listPar(),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        if (formalize) {
                          List<Product> list = [product];
                          closeDialog(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context1) =>
                                      FormalizePage(list, context)));
                        } else {
                          // AddProductInCart(context, product.route);
                          BlocProvider.of<CartCubit>(contextBloc).add(product);
                          Fluttertoast.showToast(
                              msg: "Добавлено",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                          closeDialog(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: formalize ? cPay : cButtons,
                        ),
                        width: MediaQuery.of(context).size.width - 12 * 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formalize ? "Оформить" : "Добавть в козину",
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
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

class ContentSelectParams extends StatefulWidget {
  Params params;
  Function select;

  ContentSelectParams.init({@required this.params, @required this.select});

  factory ContentSelectParams(
      {@required Params paramsA, @required ValueChanged<int> indexSelect}) {
    paramsA.params[0].select = true;
    return ContentSelectParams.init(
      params: paramsA,
      select: indexSelect,
    );
  }

  @override
  _ContentSelectParamsState createState() => _ContentSelectParamsState();
}

class _ContentSelectParamsState extends State<ContentSelectParams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.params.name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontFamily: fontFamily,
                  fontStyle: FontStyle.normal,
                  color: cTitles),
            ),
          ),
          Wrap(
            children: List.generate(
                widget.params.params.length,
                (index) => Padding(
                      padding: EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          widget.select(index);
                          widget.params.select = index;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: widget.params.select == index
                                ? Border.all(color: c8dcde0)
                                : null,
                            color: cForms,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              widget.params.params[index].name,
                              style: TextStyle(
                                  color: cMainText,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
