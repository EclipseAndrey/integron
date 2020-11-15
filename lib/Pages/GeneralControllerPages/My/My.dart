import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/DialogIntegron.dart';
import 'package:omega_qick/Utils/fun/ExitAccount.dart';

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

  initHeader() {
    RenderBox box = keyHeader.currentContext.findRenderObject();
    print("INIT HEIGHT ${box.size.height}");

    buildCompleted = true;
    initHeight =
        MediaQuery.of(context).size.height - paddingV - 100 - box.size.height;
    setState(() {});
  }

  Load() async {
    loading = true;
    setState(() {});
    String token = await tokenDB();
    user = await checkToken(token);
    loading = false;
    setState(() {});
    if (buildCompleted) initHeader();
  }

  editProfile(){
    //todo edit name
  }

  @override
  void initState() {
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
                    GestureDetector(
                      onTap:editProfile,
                      child: Text(
                        user.name ?? "Задайте имя",
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
                  child: Container(
                    height: 72,
                    color: cDefault,
                    width: 72,
                    child: user.photo == null
                        ? Center(
                            child: Text(
                            user.name == null
                                ? "A"
                                : user.name[0].toUpperCase(),
                            style: TextStyle(color: cMainText, fontSize: 24),
                          ))
                        : Image.network(
                            user.photo,
                            fit: BoxFit.cover,
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
            );
          }
        case 1:
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
                        "Избранное",
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
            return Padding(
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
            );
          }
      }
    }

    List<int> settingsMenu = [0, 1, 2, 3, 4];
    return Column(
      children: List.generate(
          settingsMenu.length,
          (index) => Column(
                children: [
                  itemMenu(index),
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
          onTap: () {
            showDialogIntegron(
                context: context,
                title: Text(
                  "Сообщение",
                  style: TextStyle(color: cMainText, fontSize: 16),
                ),
                body: Text(
                  "Поздравляем, теперь у вас Аккаунт бизнеса, не забудьте указать название вашего бизнеса, иначе пользователи не смогут увидеть его",
                  style: TextStyle(color: cMainText, fontSize: 16),
                ),
                buttons: <DialogIntegronButton>[
                  DialogIntegronButton(
                      textButton: Text(
                        "Хорошо",
                        style: TextStyle(color: cMainText, fontSize: 16),
                      ),
                      onPressed: () {
                        //todo CREATE BUSINESS
                      })
                ]);
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
                    "Открыть магазин",
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
        Padding(
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
