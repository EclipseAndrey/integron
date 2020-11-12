import 'package:flutter/material.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/FadeAnimation.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/GenerateAddress.dart';

import 'ButtonCopy.dart';
import 'ButtonISave.dart';
import 'Style.dart';

class GenerateWallet extends StatefulWidget {
  @override
  _GenerateWalletState createState() => _GenerateWalletState();
}

class _GenerateWalletState extends State<GenerateWallet> {

  bool loadingState = true;
  AddressA generated;
  void StartLoading()async{
    generated = await generateAddress(context);
    loadingState = false;
    setState(() {

    });

  }


  @override
  void initState() {
    StartLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    String seed = "copy";





    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
        ),
        child: loadingState? Center(child: CircularProgressIndicator(
          backgroundColor: Colors.purple,
        ),): Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 60,
                                child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                          ),
                        ],
                      ),
                      FadeAnimation(0.5,Text("Сохраните эту фразу на случай, если вы планируете использовать этот адрес в будущем", style: styleText1,)),
                      SizedBox(height: 40,),
                      FadeAnimation(0.7,Text("Ваша фраза", style: styleText2,),),
                      SizedBox(height: 15,),

                      FadeAnimation(0.9,Text(generated.mnemonic, style: styleText3, ),),
                      SizedBox(height: 20,),

                      FadeAnimation(0.9,ButtonCopy(generated.mnemonic)),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: FadeAnimation.withDuration(2,ButtonISave(context, generated), Duration(milliseconds: 300),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

