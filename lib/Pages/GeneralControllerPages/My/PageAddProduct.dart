import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Categories/GetCategories.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/Items/Property.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/BotomSheetSelectForIndex.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogError.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';

class AddProductPage extends StatefulWidget {

  bool edit = false;
  int id;
  AddProductPage({this.id,this.edit});


  int maxImageNo = 10;

  factory AddProductPage.edit(int id){
    return AddProductPage(id: id, edit: true);
  }
  factory AddProductPage.empty(){
    return AddProductPage(edit: false);
  }


  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  PageController controllerImageSlider = PageController();

  int maxImageNo = 10;
  bool selectSingleImage = false;
  String _platformMessage = 'No Error';

  List<Widget> imagePages = [];
  List imagelocal = [];

  int _type;
  Category _category;
  List<Category> categories;

  String nameProductDefault = "Редактировать название";
  String nameProduct =  "Редактировать название";
  String nameProductStep;
  bool editingHeaderState = false;
  TextEditingController controllerHeader = TextEditingController();

  List<Property> properties = [Property(name: "Краткое описание", value: "Нажмите для редактирования", editingValue: false, canDelete: false),Property(canDelete: false, name: "Полное описание", value: "Нажмите для редактирования", editingValue: false)];
  int idEditingProperties;
  Property editingProperty  = Property();
  TextEditingController controllerNameProperty = TextEditingController();
  TextEditingController controllerValueProperty = TextEditingController();

  String priceTitle = "Цена";
  String priceHintSumm = "Сумма";
  String priceHintUnit = "ед. изм.";
  String priceSummText = "";
  String priceUnitText = "";
  String priceSummTextStep;
  String priceUnitTextStep;
  TextEditingController controllerPriceSumm = TextEditingController();
  TextEditingController controllerPriceUnit = TextEditingController();


  bool loading = true;
  Product item;

  void saveProduct()async{


  }

  updateImagePages(){
    List<Widget> out = [];
    List<Widget> net=[];

    if(widget.edit) {
      net = List.generate(item.images.length, (index) {
        return Image.network(
          item.images[index],
          fit: BoxFit.cover,
        );
      });
      out.addAll(net);
    }

    net = List.generate(imagelocal.length, (index){
      return Image.file(
      File(imagelocal[index].toString()),
      fit: BoxFit.cover,
    );
    });


    out.addAll(net);

    imagePages = out;
    setState(() {});
  }

  deleteImage(int index){
    bool local;
    if(!widget.edit)local=true;

    if(widget.edit)if(index < item.images.length)local =false;else local= true;
    int indexL = index;
    print("Delete image $index");
    // ignore: unnecessary_statements
    if(widget.edit)imagePages.length-item.images.length+index-1;
    if(local){
      imagelocal.removeAt(indexL);
    }else{
      item.images.removeAt(index);
    }
    updateImagePages();
  }

  addImage() async {
    List resultList;
    String error;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(
          maxImageNo, selectSingleImage);
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      imagelocal.addAll(resultList);
      if (error == null) _platformMessage = 'No Error Dectected';
    });
    updateImagePages();

  }

  _selectType(int index){
    _type = index;
    setState(() {

    });
  }

  selectType()async{
    List<String> list = ["Товары","Услуги"];
    await ShowBottoomSheetSelectForIndex(
      context: context,
      items:list,
      title: "Выберите тип",
      indexSelect: _selectType,
    );
  }

  _selectCategory(int index){
    _category = categories[index];
    setState(() {

    });
  }

  selectCategory()async{
    if(categories == null){
      showDialogLoading(context);
      categories = await getCategories() as List<Category>;
      closeDialog(context);
    }
    List<String> list = [];
    List<int> icons = [];

    if(categories != null) {
      for (int i = 0; i < categories.length; i++) {
        list.add(categories[i].name);
        icons.add(categories[i].icon);
      }

      await ShowBottoomSheetSelectForIndex(
          context: context,
          items: list,
          title: "Выберите категорию",
          indexSelect: _selectCategory,
          icons: icons
      );
    }else{
      showDialogError(context);
    }
  }

  initProperties(){
    if(widget.edit){
      properties.addAll(item.property);
    }
  }

  addProperty(){
    print("add p");
    properties.add(Property());
    setState(() {

    });
    editProperty(properties.length-1);
  }

  saveProperty(){
    print("save p $idEditingProperties");

    if(idEditingProperties != null) {
      print("1111");
      if (editingProperty != null &&(editingProperty.name != "" && editingProperty.value != "")&&(editingProperty.name != null && editingProperty.value != null)) {
        print("2222 ${editingProperty.name} ${editingProperty.value}");

        properties[idEditingProperties] = editingProperty;
      }else {
        if ((properties[idEditingProperties].name == "" && properties[idEditingProperties].value == "")||(properties[idEditingProperties].name == null && properties[idEditingProperties].value == null)) {
          print("3333");

          deleteProperty(
              idEditingProperties);
        }
      }
      idEditingProperties = null;
      editingProperty = Property();
      controllerNameProperty.text = "";
      controllerValueProperty.text = "";
      setState(() {});
    }
  }

  deleteProperty(int index){
    print("delete p");
    try {
      properties.removeAt(index);
    }catch(e){}
    setState(() {});

  }

  editProperty(int index){
    print("edit p");

    saveStats();

    idEditingProperties = index;
    setState(() {

    });

    editingProperty = Property(name:properties[index].name, value: properties[index].value, editingName:properties[index].editingName, editingValue: properties[index].editingValue,canDelete: properties[index].canDelete );
    controllerNameProperty.text = properties[index].name;
    controllerValueProperty.text = properties[index].value;
  }

  editHeader(){

    saveStats();

    controllerHeader.text = nameProduct;
    editingHeaderState = true;
    setState(() {});

  }

  saveHeader(){
    if(nameProductStep != "" && nameProductStep != null){
      nameProduct = nameProductStep;
      editingHeaderState = false;
    }else{
      editingHeaderState = false;
    }
    setState(() {});
  }

  editPrice(){
    saveStats();
    priceSummTextStep = priceSummText;
    priceUnitTextStep = priceUnitText;
    controllerPriceSumm.text = priceSummTextStep;
    controllerPriceUnit.text = priceUnitTextStep;
    setState(() {});
  }

  savePrice(){
    if(controllerPriceSumm.text != "" && controllerPriceUnit.text != ""){
      priceUnitText = controllerPriceUnit.text;
      priceSummText = controllerPriceSumm.text;
    }
    priceSummTextStep = null;
    priceUnitTextStep = null;
    setState(() {});

  }

  updateImageDetails(){}

  deleteImageDetails(int index){}

  addImageDetails(){}


  saveStats(){
    saveHeader();
    savePrice();
    saveProperty();
  }

  void load()async{
    item = await getProductForId(widget.id);

    if (item.error == null) {
      updateImagePages();
      _type = item.type;
      _category= item.catPath[0];
      initProperties();
      nameProduct = item.name;

    }
    loading= false;
    setState(() {});
  }

  @override
  void initState() {

    controllerValueProperty.addListener(() {
      editingProperty.value = controllerValueProperty.text;
    });
    controllerNameProperty.addListener(() {
      editingProperty.name = controllerNameProperty.text;
    });
    controllerHeader.addListener(() {
      nameProductStep = controllerHeader.text;
    });
    controllerPriceUnit.addListener(() {
      priceUnitTextStep = controllerPriceUnit.text;
    });
    controllerPriceSumm.addListener(() {
        priceSummText = controllerPriceSumm.text;
    });


    if(!widget.edit) {
      loading = false;
      setState(() {

      });
    }else{
      load();
    }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cBG,
        elevation: 0,
      ),
      body: Content(),
    );
  }

  Widget Content(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
      SingleChildScrollView(
        child: Column(
          children: [
            ImageSlider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySelect(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Header(),

                  ),
                  Price(),
                  ConstructorProperty(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget editContainer(){
    return Column(
      children: [
        Divider(color: cDefault, ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color:  Color.fromRGBO(141, 205, 224, 1),
              width: 2
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    properties[idEditingProperties].editingValue?Container(
                      width: MediaQuery.of(context).size.width*0.80,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(153, 155, 158, 1),
                          ),
                          hintText: "Название",
                        ),
                        style: TextStyle(
                            color: Color.fromRGBO(47, 82, 127, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: fontFamily
                        ),
                        controller: controllerNameProperty,
                      ),
                    ):Text(
                      editingProperty.name,
                      style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                    ),
                    GestureDetector(
                        onTap: (){
                          saveProperty();
                        },
                        child: Container(child: Icon(Icons.check, color: c6287A1, size: 24,))),

                  ],
                ),
                Container(
                  //width: MediaQuery.of(context).size.width-24-10,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(153, 155, 158, 1),
                      ),
                      hintText: "Описание",
                    ),
                    style: TextStyle(
                        color: cMainText,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily
                    ),
                    controller: controllerValueProperty,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }



  Widget ImageSlider() {
    controllerImageSlider.addListener(() {
      setState(() {});
    });
    return GestureDetector(
      onTap: (){
        addImage();
      },
      child: Container(
        color: cDefault,
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: imagePages.length == 0
            ? Center(
          child: Icon(Icons.add_photo_alternate),
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
                          borderRadius: BorderRadius.circular(6)
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controllerImageSlider.positions.length == 0
                              ? "1 / ${imagePages.length}"
                              : "${controllerImageSlider.page.round() + 1} / ${imagePages.length}",
                          style:
                          TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment:  Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: ()async{
                    addImage();
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      color: cDefault,
                      borderRadius: BorderRadius.circular(6)

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getIconForId(id: 22, color: c6287A1, size: 24),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment:  Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipOval(
                  child: GestureDetector(
                    onTap: (){
                      deleteImage(controllerImageSlider.page.round());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: cDefault,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: getIconForId(id: 8, color: c6287A1, size: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CategorySelect(){


    String typeWord(int type){
      if(type == 0){return "Товары";}else if(type == 1){return "Услуги";}else{return "Выберите тип";}
    }

    if(_type == null){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              selectType();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Text("Выберите тип", style: TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),),
                    SizedBox(width: 4,),
                    getIconForId(id: 38, size: 12, color: c6287A1),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }else{

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              selectType();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Text(typeWord(_type), style: TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),),
                    SizedBox(width: 4,),
                    getIconForId(id: 38, size: 12, color: c6287A1),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4,),
          Text(" / " , style: TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),),
          SizedBox(width: 4,),
          GestureDetector(
            onTap: (){
              selectCategory();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Text(_category == null?"Выберите категорию":_category.name, style: TextStyle(color: cMainText, fontSize: 14 , fontFamily: fontFamily),),
                    SizedBox(width: 4,),
                    getIconForId(id: 38, size: 12, color: c6287A1),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget ConstructorProperty(){

    Widget buttonAdd(){
      return GestureDetector(
        onTap: (){
          addProperty();
        },
        child: Container(
          width: MediaQuery.of(context).size.width-24,
          
          decoration: BoxDecoration(
            color: c8dcde0,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Добавть параметр", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
          ),),
        ),
      );
    }


    Widget generatorProperties(){
      return Column(
        children: List.generate(properties.length, (index) {
          if(idEditingProperties != null && idEditingProperties == index){
            return editContainer();
          }else{
            return GestureDetector(
              onTap: (){
                editProperty(index);
              },
              child: Container(
                child: Column(
                  children: [
                    Divider(color: cDefault, ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width*0.90,
                              child: Text(
                                properties[index].name,
                                style: TextStyle(
                                    color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                              ),
                            ),
                            SizedBox(height:  4,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.90,

                              child: Text(
                                properties[index].value,
                                style: TextStyle(
                                    color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                              ),
                            ),
                          ],
                        ),
                        properties[index].canDelete?Padding(
                          padding: const EdgeInsets.only(top:0.0),
                          child: GestureDetector(
                              onTap: (){
                                deleteProperty(index);
                              },
                              child: getIconForId(id: 8, color: c6287A1)),
                        ):SizedBox(),

                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      );
    }

    if(properties.length == 0){

      return Column(
        children: [
          buttonAdd(),
        ],
      );
    }else{
      return Column(
        children: [
          generatorProperties(),
          SizedBox(height: 8,),
          idEditingProperties != null? SizedBox():buttonAdd(),

        ],
      );
    }
  }

  Widget EditHeader(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color:  Color.fromRGBO(141, 205, 224, 1),
              width: 2
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.80,
                  child: TextField(
                    maxLines: null,
                    maxLength: 50,
                    maxLengthEnforced: true,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(153, 155, 158, 1),
                      ),
                      hintText: "Название",
                    ),
                    style: TextStyle(
                        color: Color.fromRGBO(47, 82, 127, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily
                    ),
                    controller: controllerHeader,
                  ),
                ),
                GestureDetector(
                    onTap: (){
                      saveHeader();
                    },
                    child: Container(child: Icon(Icons.check, color: c6287A1, size: 24,))),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Header(){
    return editingHeaderState?EditHeader():GestureDetector(
      onTap: (){
        editHeader();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(nameProduct, style: TextStyle(color: Color.fromRGBO(88,148,188,1), fontSize:  24, fontFamily:  fontFamily, fontWeight:  FontWeight.w400, fontStyle:  FontStyle.normal),)),
        ],
      ),
    );

  }


  Widget Price(){

    Widget priceStateSave(){
      return GestureDetector(
        onTap: (){
          editPrice();
        },
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(priceTitle, style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),),
                ],
              ),
              Row(
                children: [
                  Text(priceSummText ==""?"СУММА":priceSummText,  style: TextStyle(color: Color.fromRGBO(88,148,188,1), fontSize:  20, fontFamily:  fontFamily, fontWeight:  FontWeight.w700, fontStyle:  FontStyle.normal),),
                  Text(" DEL ",  style: TextStyle(color: Color.fromRGBO(88,148,188,1), fontSize:  18, fontFamily:  fontFamily, fontWeight:  FontWeight.w400, fontStyle:  FontStyle.normal),),
                  Text(" / ", style: TextStyle(color: cMainText.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                  Text(priceUnitText == ""?priceHintUnit:priceUnitText, style: TextStyle(color: cMainText.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
                ],
              ),

            ],
          ),
        ),
      );
    }

    return priceUnitTextStep==null?priceStateSave():Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(priceTitle, style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),),
                 GestureDetector(
                     onTap: (){
                       savePrice();
                     },
                     child: Container(child: Icon(Icons.check, color: c6287A1, size: 24,))),
               ],
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width/2)-24-10-10,
                  child: TextField(
                    textAlign: TextAlign.end,

                    keyboardType: TextInputType.number,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(153, 155, 158, 1),
                      ),
                      hintText: priceHintSumm,
                    ),
                    style: TextStyle(
                        color: cMainText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontFamily
                    ),
                    controller: controllerPriceSumm,
                  ),
                ),
                Text(" DEL /"),
                Container(
                  width: (MediaQuery.of(context).size.width/2)-24-10-10,
                  child: TextField(
                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(153, 155, 158, 1),
                      ),
                      hintText: priceHintUnit,
                    ),
                    style: TextStyle(
                        color: cMainText,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily
                    ),
                    controller: controllerPriceUnit,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );


  }


}