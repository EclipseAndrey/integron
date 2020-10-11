import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:omega_qick/Contacts/DataBase/AddContacts.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/GetContactForId.dart';
import 'package:omega_qick/Contacts/Pages/AddContact.dart';
import 'package:omega_qick/Contacts/Pages/ContactInfo.dart';
import 'package:omega_qick/Contacts/Sort.dart';
import 'package:omega_qick/Style.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'AddContactContent/AddContactController.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool loading = true;
  List<Contact> contacts = [];
  List<List<Contact>> contactsOfSort = [];
  List<Contact> contactsFavourites = [];

  void update() async {
    contacts = await getContacts();
    contactsOfSort = sortContacts(contacts);
    contactsFavourites = [];
    for(int i = 0; i < contactsOfSort.length; i++){
      for(int j = 0; j < contactsOfSort[i].length; j++){
        if(contactsOfSort[i][j].priory == 1)contactsFavourites.add(contactsOfSort[i][j]);
      }
    }


    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  var empty = [
    SizedBox(
      height: 50,
    ),
    Center(
        child: Text(
      "У вас пока нет контактов",
      style: TextStyle(color: Colors.white, fontFamily: "MPLUS"),
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async{
                await Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactContent()));
               //await AddContactBottomSheet(context);

               update();
               setState(() {

               });
              },
            )
          ],
          backgroundColor: homeBackgroundGradient[0],
          title: Text("Контакты"),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: homeBackgroundGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomCenter)),
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :
                // Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: MediaQuery.of(context).size.height,
                //         child: CustomScrollView(
                //           slivers: [
                //             SliverAppBar(
                //               backgroundColor: homeBackgroundGradient[0],
                //               title: Text('Контакты'),
                //               automaticallyImplyLeading: false,
                //               pinned: true,
                //               actions: [
                //                 IconButton(
                //                   icon: Icon(
                //                     Icons.add,
                //                     color: Colors.white,
                //                   ),
                //                   onPressed: () {
                //                     AddContactBottomSheet(context);
                //                   },
                //                 )
                //               ],
                //             ),
                //             contactsOfSort.length == 0
                //                 ? SliverToBoxAdapter(
                //                     child: Container(
                //                       height: 50,
                //                       color: Colors.transparent,
                //                     ),
                //                   )
                //                 : CustomScrollView(
                //                     slivers: List.generate(
                //                       contactsOfSort.length,
                //                       (index) => _StickyHeaderList(
                //                         contacts: contactsOfSort[index],
                //                       ),
                //                     ),
                //                     // slivers: genHead(contactsOfSort.length,),
                //                   ),
                //
                //             // (context, index) => _StickyHeaderList(
                //             // contacts: contactsOfSort[index],
                //             // ),
                //             // childCount: contactsOfSort.length,
                //           ],
                //         ),
                //       ),
                Content()),
      ),
    );
  }

  Widget Content() {
    Widget Favorites(List<Contact> contacts) {
      return contacts.length ==0?SizedBox():Column(
        children: [
          Container(
            height: 30,
            color: Colors.white10,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Избранные",
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: "MPLUS"),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: List.generate(contacts.length, (index) {
              return ListTile(
                onTap: ()async{
                  await  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactInfo(contacts[index])));

                  update();
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(contacts[index].name[0].toUpperCase(), style: TextStyle(color: Colors.black),),
                  ),
                ),
                hoverColor: Colors.black45,
                title: Text(
                  contacts[index].name,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
          )
        ],
      );
    }
    Widget Item(List<Contact> contacts) {
      return Column(
        children: [
          Container(
            height: 30,
            color: Colors.white10,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    contacts[0].name[0].toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: "MPLUS"),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: List.generate(contacts.length, (index) {
              return ListTile(
                onTap: ()async{
                  await  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactInfo(contacts[index])));

                  update();
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(contacts[index].name[0].toUpperCase(), style: TextStyle(color: Colors.black),),
                  ),
                ),
                hoverColor: Colors.black45,
                title: Text(
                  contacts[index].name,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
          )
        ],
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: Column(
          children: [

            Favorites(contactsFavourites),

            Column(
              children: List.generate(contactsOfSort.length, (index) => Item(contactsOfSort[index])),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> genHead(int count) {
    print("===========$count");
    List<Widget> out = [];
    for (int i = 0; i < count; i++) {
      out.add(
        _StickyHeaderList(
          contacts: contactsOfSort[i],
        ),
      );
    }
    return out;
  }
}

class _StickyHeaderList extends StatelessWidget {
  List<Contact> contacts;

  _StickyHeaderList({this.contacts});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Header(
            title: contacts[0].name[0],
          )),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListTile(
              leading: CircleAvatar(
                child: Text('T'),
              ),
              title: Text(contacts[i].name),
            ),
          ),
          childCount: contacts.length,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String title;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? 'Header #$index',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
