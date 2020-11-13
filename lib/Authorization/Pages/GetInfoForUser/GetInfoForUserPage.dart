import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/Style.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/REST/Autorization/SetNameR.dart';
import 'package:omega_qick/REST/Autorization/setRole.dart';
import 'package:omega_qick/Style.dart';

class GetInfoForUserPage extends StatefulWidget {
  @override
  _GetInfoForUserPageState createState() => _GetInfoForUserPageState();
}

class _GetInfoForUserPageState extends State<GetInfoForUserPage> {
  bool business = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {

      });
    });
    return Theme(
      data: themeApp,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                switchButton(),
                SizedBox(
                  height: 50,
                ),
                name(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget switchButton() {
    return Column(
      children: [
        Text(
          "Выберите тип аккаунта",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                business = false;
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  color: business ? Colors.transparent : Colors.purple,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Покупатель",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                business = true;
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  color: !business ? Colors.transparent : Colors.purple,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Бизнес",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget name() {
    return Column(
      children: [
        Text(
          business ? "Название бизнеса" : "Как к вам обращаться?",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 24),
        ),
        SizedBox(
          height: 30,
        ),
        inputName(),
        SizedBox(
          height: 30,
        ),
        buttonNext(),
      ],
    );
  }

  Widget inputName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        style: styleTextSeed,
        cursorColor: cursorColor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.pink),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: colorBorderSideOutSeed,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.pink,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: colorBorderSideActiveSeed,
                width: 2.0,
              ),
            ),

            // focusedBorder: InputBorder.none,
            // errorBorder: InputBorder.none,
            // disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: business ? "Название бизнеса" : "Имя",
            hintStyle: hintTextSeed),
      ),
    );
  }

  Widget buttonNext() {
    return GestureDetector(
      onTap: ()async{
        if(controller.text != ""){
          if(await GetSetName(controller.text) == 200){
            if(await setRoleR(business?"1":"0") == 200){
              AutoRoutes(context);
            }
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.purple),
          color: controller.text == ""?Colors.transparent : Colors.purple,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Продолжить",
              style: TextStyle(
                  color: controller.text == ""?Colors.white70:Colors.white, fontWeight: controller.text == ""?FontWeight.w300:FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
