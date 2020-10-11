// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'FadeAnimation.dart';
// import 'JsonParse.dart';
// import 'balance.dart';
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   void _onLoading(String numm) async {
//
// //    for debug
//     String numm = "dx19gt49xy8530wrewchjvrvgpm4r4wu3s25csr0a";
//
//     String urlQuery = "https://mainnet-gate.decimalchain.com/api/address/$numm?txLimit=10";
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white38,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25)
//               ),
//
//             ),
//             width: MediaQuery.of(context).size.width*2/3,
//             height: 80,
//             child: Center(
//               child: new CircularProgressIndicator(),
//             ),
//           ),
//
//         );
//       },
//     );
//
//     var response = await http.get(urlQuery);
//     print(response.body);
//
//     Future.delayed( Duration(seconds: 3), () async {
//       print('start delay');
//       User _user;
//
//       void _processResponse(http.Response response) {
//         print(response.body.toString()+"=======");
//
//         if (response.statusCode == 200) {
//           setState(() {
//             _user = User.fromJson(json.decode(response.body));
//             print(response.body.toString());
//           });
//         }
//       }
//
//       print(urlQuery);
//       await http.get(urlQuery);
//       _processResponse(response);
//
//
//       Navigator.of(context).pop();
//       Navigator.push(context, MaterialPageRoute(builder: (context) => PageBalance(_user)));
//
//
//
//     });
//
//   }
//
//
//
//   TextEditingController controller = TextEditingController();
//   bool check = true;
//   String title = "Omega";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [
//                   Color.fromRGBO(34, 15, 45, 1),
//                   Color.fromRGBO(34, 15, 45, 0.8),
//                   Color.fromRGBO(34, 15, 45, 0.5)
//                 ]
//             )
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 60,),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   FadeAnimation(1, Text(title, style: TextStyle(color: Colors.white, fontSize: 40),)),
//                   SizedBox(height: 10,),
//                   FadeAnimation(1.3, Text("Добро пожаловать", style: TextStyle(color: Colors.white, fontSize: 20),)),
//                   SizedBox(height: 30,)
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
//                 ),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(30),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(height: 70,),
//                         FadeAnimation(1.4, Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [BoxShadow(
//                                   color: Color.fromRGBO(34, 15, 45, .3),
//                                   blurRadius: 20,
//                                   offset: Offset(0, 10)
//                               )]
//                           ),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                                 ),
//                                 child: TextField(
//                                   controller: controller,
//                                   decoration: InputDecoration(
//                                       hintText: "Адресс кошелька",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       border: InputBorder.none
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                         SizedBox(height: 60,),
//                         GestureDetector(
//                           onTap: () async {
//                             _onLoading(controller.text);
//
//                           },
//                           child: FadeAnimation(1.6, Container(
//                             height: 50,
//                             margin: EdgeInsets.symmetric(horizontal: 30),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Color.fromRGBO(25, 1, 58, 1)
//                             ),
//                             child: Center(
//                               child: Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
//                             ),
//                           )),
//                         ),
//                         SizedBox(height: 20,),
//                         FadeAnimation(1.5,
//                           (
//                               check ?
//                               GestureDetector(
//                                   onTap: (){
//                                     title = "Регистрация";
//                                     setState(() {
//                                       check = false;
//                                     });
//                                   },
//                                   child: Container(
//                                       height: 40,
//                                       width: 230,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10),
//                                           border: Border.all(color: Color.fromRGBO(25, 1, 58, 1), width: 1)
//                                       ),
//                                       child: Center(child: Text("Создать аккаунт", style: TextStyle(fontSize: 18, color: Color.fromRGBO(25, 1, 58, 1), fontWeight: FontWeight.normal),)))
//                               )
//                                   :
//                               GestureDetector(
//                                   onTap: (){
//                                     title = "Вход";
//                                     setState(() {
//                                       check = true;
//                                     });
//                                   },
//                                   child: Container(
//                                       height: 40,
//                                       width: 230,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10),
//                                           border: Border.all(color: Color.fromRGBO(255, 188, 173, 1), width: 1)
//                                       ),
//                                       child: Center(child: Text("Войти", style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 188, 173, 1), fontWeight: FontWeight.normal),)))
//                               )
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
