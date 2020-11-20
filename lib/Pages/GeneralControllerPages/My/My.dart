import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/AboutIntegron/AboutIntegron.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/SetNameR.dart';
import 'package:omega_qick/REST/Autorization/SetPhoto.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/REST/Autorization/setRole.dart';
import 'package:omega_qick/REST/SendPhoto.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/DialogIntegron.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/Utils/fun/ExitAccount.dart';
import 'package:omega_qick/reqests.dart';
import 'package:http/http.dart' as http;

import 'Buisness/Buisness.dart';
import 'Orders/OrdersBiz/OrdersBiz.dart';
import 'Orders/OrdersMy/OrdersMy.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  GlobalKey keyHeader = GlobalKey();
  double paddingV = 24;
  double paddingH = 18;
  InfoToken user;
  bool loading = true;

  double initHeight = 100;

  bool buildCompleted = false;

  bool editingName = false;
  FocusNode focusName = FocusNode();
  TextEditingController controllerEditName = TextEditingController();

  initHeader() {
    RenderBox box = keyHeader.currentContext.findRenderObject();
    print("INIT HEIGHT ${box.size.height}");

    buildCompleted = true;
    initHeight =
        MediaQuery.of(context).size.height - paddingV - 100 - box.size.height;
    setState(() {});
  }
  List<int> settingsMenu = [0,1,4];
  Load() async {
    print("load");
    loading = true;
    setState(() {});
    String token = await tokenDB();
    user = await checkToken(token);
    user??Fluttertoast.showToast(
        msg: "Не удалось загрузить",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    while(user == null){
      user = await checkToken(token);
      user??Fluttertoast.showToast(
          msg: "Не удалось загрузить",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    user.role == 1?settingsMenu = [0,1,4]:settingsMenu=[0,4];
    loading = false;
    setState(() {});
    if (buildCompleted) initHeader();

  }

  editProfile()async{
    editingName = !editingName;
    if(user != null && user.name!=null&& editingName){
      controllerEditName.text = user.name;
    }
    if(editingName){

    }
    if(!editingName){
      user.name = controllerEditName.text;
      await GetSetName(controllerEditName.text);
    }
    Load();
    setState(() {});
    initHeader();
  }






  setImage()async{
    final picker = ImagePicker();

    String path = "";
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {});
      if (pickedFile != null) {
        path = pickedFile.path;

        String url = "http://194.226.171.139:14880/apitest.php/uploadPhoto";

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(
            http.MultipartFile(
                'var_file',
                File(path).readAsBytes().asStream(),
                File(path).lengthSync(),
                filename: path.split("/").last
            )
        );
        var res = await request.send();
        //     .then((value){
        //
        // });
        //print("req "+ res.request.toString());

        res.stream.transform(utf8.decoder).listen((value) async{
          print(value);
          await setPhoto(json.decode(value)['url']);
          Load();
          initHeader();

          print("load start");
        });




      } else {
        print('No image selected.');
      }

  }




  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark
      //       (
      //   //statusBarColor: cBackground,
      //   systemNavigationBarColor: Color(0x00cccccc),
      //   systemNavigationBarDividerColor: null,
      //   statusBarColor: Color(0xFFffffff),
      //   systemNavigationBarIconBrightness: Brightness.light,
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarBrightness: Brightness.light,
      // ),
    );
    focusName.addListener(() {
      print("FOCUS NAME"+focusName.hasFocus.toString());
      if(!focusName.hasFocus){
        editProfile();
      }
    });
    super.initState();

    Load();

    WidgetsBinding.instance.addPostFrameCallback((_) => initHeader());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Content()),
        ),
      ),
    );
  }

  Widget editName(){
    return Container(
        width: MediaQuery.of(context).size.width/2,
        child: TextField(
          autofocus: true,
          focusNode: focusName,
          controller: controllerEditName,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(153, 155, 158, 1),
            ),
            hintText: "Имя",
          ),
        ));
  }

  Widget Content() {
    return Column(
      children: [
        Container(
          key: keyHeader,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _header(),
        ),
        Container(
          height: initHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(
                  color: cd1d3d7,
                ),
                _body(),
                loading ? SizedBox() : _openStore(),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    editingName?editName():GestureDetector(
                      onTap:editProfile,
                      child: Text(
                        (user.name == null || user.name.length == 0)? "Задайте имя":user.name,
                        style: TextStyle(
                            color: user.name == null ? cLinks : cMainText,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: fontFamily),
                      ),
                    ),
                    SizedBox(
                      height: paddingV / 2 / 3 * 1,
                    ),
                    Text(
                      "+" + user.num,
                      style: TextStyle(
                          color: cPlaceHolder,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: fontFamily),
                    ),
                    //todo name num
                  ],
                ),
                SizedBox(
                  height: paddingV / 2 / 3 * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap:editProfile,
                      child: Text(
                        "Изменить",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            fontStyle: FontStyle.normal,
                            color: cLinks),
                      ),
                    ),
                    SizedBox(
                      width: paddingH,
                    ),
                    GestureDetector(
                        onTap: () async {
                          await ExitAccount();
                          AutoRoutes(context);
                        },
                        child: Text(
                          "Выйти",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: fontFamily,
                              fontStyle: FontStyle.normal,
                              color: cLinks),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: GestureDetector(
                    onTap: (){
                      print('tap set photo');
                      setImage();
                    },
                    child: Container(
                      height: 72,
                      color: cDefault,
                      width: 72,
                      child: user.photo == null
                          ? Center(
                              child: Text(
                              user.name == null
                                  ? "A"
                                  : user.name.length == 0?"A":user.name[0].toUpperCase(),
                              style: TextStyle(color: cMainText, fontSize: 24),
                            ))
                          : Image.network(
                              user.photo,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    Widget itemMenu(int index) {
      switch (index) {
        case 0:
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: paddingH),
              child: GestureDetector(
                onTap: (){
                  //OrdersBiz
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrdersMy()));

                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getIconForId(id: 15, color: cIcons),
                          SizedBox(
                            width: paddingH / 2,
                          ),
                          Text(
                            "Мои покупки",
                            style: TextStyle(
                                color: cMainText,
                                fontStyle: FontStyle.normal,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      getIconForId(id: 39, color: cIcons)
                    ],
                  ),
                ),
              ),
            );

          }
        case 1:
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: paddingH),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrdersBiz()));

                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getIconForId(id: 15, color: cIcons),
                          SizedBox(
                            width: paddingH / 2,
                          ),
                          Text(
                            "Заказы магазина",
                            style: TextStyle(
                                color: cMainText,
                                fontStyle: FontStyle.normal,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      getIconForId(id: 39, color: cIcons)
                    ],
                  ),
                ),
              ),
            );
          }
        case 2:
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: paddingH),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getIconForId(id: 34, color: cIcons),
                      SizedBox(
                        width: paddingH / 2,
                      ),
                      Text(
                        "Настройки",
                        style: TextStyle(
                            color: cMainText,
                            fontStyle: FontStyle.normal,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  getIconForId(id: 39, color: cIcons)
                ],
              ),
            );
          }
        case 3:
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: paddingH),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getIconForId(id: 15, color: cIcons),
                      SizedBox(
                        width: paddingH / 2,
                      ),
                      Text(
                        "Поддержка",
                        style: TextStyle(
                            color: cMainText,
                            fontStyle: FontStyle.normal,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  getIconForId(id: 39, color: cIcons)
                ],
              ),
            );
          }
        case 4:
          {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AboutIntegron()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: paddingH),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getIconForId(id: 36, color: cIcons),
                        SizedBox(
                          width: paddingH / 2,
                        ),
                        Text(
                          "Об INTEGRON",
                          style: TextStyle(
                              color: cMainText,
                              fontStyle: FontStyle.normal,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    getIconForId(id: 39, color: cIcons)
                  ],
                ),
              ),
            );
          }
      }
    }


    return Column(
      children: List.generate(
          settingsMenu.length,
          (index) => Column(
                children: [
                  itemMenu(settingsMenu[index]),
                  Divider(
                    color: cDefault.withOpacity(0.5),
                  )
                ],
              )),
    );
  }

  Widget _openStore() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: paddingV,
        ),
        GestureDetector(
          onTap: () async{
            showDialogLoading(context);
            InfoToken info = await checkToken(await tokenDB());
            closeDialog(context);
              if(info.role == 1){
                await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusinessPage.edit()));
              }else{
                showDialogLoading(context);
                await setRoleR("1");
                closeDialog(context);
                showDialogIntegron(
                    context: context,
                    title: Text(
                      "Сообщение",
                      style: TextStyle(color: cMainText, fontSize: 16,fontFamily: fontFamily),
                    ),
                    body: Text(
                      "Поздравляем, теперь у вас Аккаунт бизнеса, не забудьте указать название вашего бизнеса, иначе пользователи не смогут увидеть его",
                      style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    buttons: <DialogIntegronButton>[
                      DialogIntegronButton(
                          textButton: Text(
                            "Хорошо",
                            style: TextStyle(color: cMainText, fontSize: 16),
                          ),
                          onPressed: () async{
                            closeDialog(context);
                            showDialogLoading(context);
                            await setRoleR("1");

                            InfoToken info = await checkToken(await tokenDB());
                            closeDialog(context);
                            if(info.role == 1){
                              await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusinessPage.edit()));
                              Load();
                            }else{
                              showDialogIntegron(context: context,
                                  title: Text("Сообщение",  style: TextStyle(color: cMainText, fontSize: 16,fontFamily: fontFamily),),
                                  body: Text("Бизнес аккаунт еще не активирован :(\nПопробуйте позже",
                                    style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
                                    textAlign: TextAlign.center, ));
                            }

                          })
                    ]);



            }

          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: cSecondaryButtons,
            ),
            width: MediaQuery.of(context).size.width - paddingH * 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getIconForId(id: 44, color: cIcons),
                  SizedBox(
                    width: paddingH / 2,
                  ),
                  Text(
                    user.role == 1?"В магазин":"Открыть магазин",
                    style: TextStyle(
                        color: cTitles,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: paddingH / 2,
        ),
        user.role == 1?SizedBox():Padding(
          padding: const EdgeInsets.only(left: 30, right: 42),
          child: Text(
            "В INTEGRON вы можете открыть свой собственный магазин и начать зарабатывать прямо сейчас.",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamily,
                fontStyle: FontStyle.normal),
          ),
        ),
      ],
    );
  }
}
