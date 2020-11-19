import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Categories/GetCategories.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'package:omega_qick/REST/Product/AddProductPost.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/DB/Items/Property.dart';
import 'package:omega_qick/Utils/DB/Params/Param.dart';
import 'package:omega_qick/Utils/DB/Params/Params.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';
import 'package:omega_qick/Utils/fun/BotomSheetSelectForIndex.dart';
import 'package:omega_qick/Utils/fun/DialogIntegron.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogError.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/reqests.dart';

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
  final picker = ImagePicker();


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


  List<Params> paramsList = [];
  Params paramsStep = Params(name: "");
  List<int> editingParam;
  TextEditingController controllerParams = TextEditingController();




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
  List<String> responsePhoto = [];

  Future<bool> uploadPhoto (String filename) async {
    String url = server14880+"/apitest.php/uploadPhoto";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile(
            'var_file',
            File(filename).readAsBytes().asStream(),
            File(filename).lengthSync(),
            filename: filename.split("/").last
        )
    );
    var res = await request.send();
    //     .then((value){
    //
    // });
    res.stream.transform(utf8.decoder).listen((value) {
      print(value);
      responsePhoto.add(json.decode(value)['url']);
    });

  }

  bool checkSumm(String s) {
    print(s);
    var stroka = RegExp("([0-9]+)\.([0-9]+)");
    print(stroka.hasMatch(s));
    return stroka.hasMatch(s);
  }

  void saveProduct()async{
    if(imagelocal.length == 0){
      dialogErr("Добавьте минимум одно фото");
    }else if(_type == null){
      //dialogErr("Выберите тип");
      selectType();
    }else if(_category == null){
      selectCategory();
    }else if(nameProduct == null || nameProduct == ""||nameProduct == " "||nameProduct == "Редактировать название"){
      await dialogErr("Укажите название продукта");
      editHeader();
    }else if(properties[0].value == "Нажмите для редактирования"||properties[0].value == "" || properties[0].value ==" "){
      dialogErr("Напишите краткое описание");

    }else if(properties[1].value == "Нажмите для редактирования" || properties[1].value==""||properties[1].value == ""){
      dialogErr("Напишите описание");
    }else{
      bool findError = false;
      for(int i =0; i < paramsList.length;i++) {
        try {
          if (paramsList[i].name == null || paramsList[i].name == "" ||
              paramsList[i].name == " ") {
            findError = true;
            i = paramsList.length;
          } else if (paramsList[i].params[0] == null ||
              paramsList[i].params[0].name == null ||
              paramsList[i].params[0].name == "" ||
              paramsList[i].params[0].name == " ") {
            findError = true;
            i = paramsList.length;
          }
          if (paramsList[i].params[1] == null ||
              paramsList[i].params[1].name == null ||
              paramsList[i].params[1].name == "" ||
              paramsList[i].params[1].name == " ") {
            findError = true;
            i = paramsList.length;
          } else {
            try {
              for (int j = 2; j < paramsList.length; j++) {
                if (paramsList[i].params[j].name == null ||
                    paramsList[i].params[j].name == "" ||
                    paramsList[i].params[j].name == " ") {
                  try {
                    paramsList[i].params.removeAt(j);
                  } catch (e) {}
                }
              }
            }catch(e){}
          }
        }catch(e){
          findError=true;
          print(e);
        }
      }
      if(findError){
        dialogErr("Заполните неполные параметры или удалите ненужные. Параметры должны содержать минимум два значения");
      }else{
        if(priceSummText == null || priceSummText == ""|| " " == priceSummText ) {
          dialogErr("Сумма не указана или указана некорректно. Укажите в формате 123.00");
        }else if(priceUnitText == null || priceUnitText == ""|| " " == priceUnitText) {
            dialogErr("Укажите единицу измерения");
          }else if(!checkSumm(priceSummText)){
          dialogErr("Сумма не указана или указана некорректно. Укажите в формате 123.00");

        } else{
            try{
              double.parse(priceSummText);
              print("OK");
              showDialogLoading(context);
              responsePhoto = [];
              for(int i = 0; i < imagelocal.length; i++){
                await uploadPhoto(imagelocal[i]);
              }

              String steptx = properties[1].value;
              String steptxS = properties[0].value;
              properties.removeAt(0);
              properties.removeAt(0);
              Product productFormForSend = Product(

                images: responsePhoto,
                owner: null,
                name: nameProduct,
                ownerName: null,
                catPath: [],
                text: steptx,
                fullText: steptxS,
                route: null,
                price: double.parse(priceSummText),
                type: _type,
                unit: priceUnitText,
                detail: [],
                delivery: "1",
                image: null,
                property: properties,
                params: paramsList,
                  cat: _category.route

              );
              int res = await addProductPost(productFormForSend);
              closeDialog(context);
              if(res==null?0:res == 200){
                closeDialog(context);
                dialogErr("Товар успешно добавлен");
              }else{
                closeDialog(context);
                dialogErr("Что - то пошло не так, попробуйте позже");
              }
            }catch(e){
              print(e);
            }
          }
      }
    }
  }

  dialogErr(String text)async{
    await showDialogIntegron(context: context,
        title: Text("Сообщение",  style: TextStyle(color: cMainText, fontSize: 16,fontFamily: fontFamily),),
        body: Text(text,
          style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
          textAlign: TextAlign.center, ));
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

  // getImage() async {
  //   List resultList;
  //   String error;
  //   try {
  //     resultList = await FlutterMultipleImagePicker.pickMultiImages(
  //         maxImageNo, selectSingleImage);
  //   } on PlatformException catch (e) {
  //     error = e.message;
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     imagelocal.addAll(resultList);
  //     if (error == null) _platformMessage = 'No Error Dectected';
  //   });
  //   updateImagePages();
  //
  // }


  Future addImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imagelocal.add(pickedFile.path);
        updateImagePages();

      } else {
        print('No image selected.');
      }
    });
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

  initParams(){
    paramsList = item.params;
  }

  addParams(){
    saveStats();
    paramsList.add(Params(name: "", params: [Param(name: ""), Param(name: "")]));
     editParams(indexX: paramsList.length-1,);
    setState(() {});

  }

  saveParams(){

    if(editingParam != null && editingParam[0] != null&& editingParam[1] != null) {
      // try {
        paramsList[editingParam[0]].params[editingParam[1]].name =
            controllerParams.text;
      // }catch(e){
      //   paramsList = null;
      // }
    }else

      if(editingParam != null && editingParam[0] != null){
        paramsList[editingParam[0]].name =controllerParams.text;
      }

      editingParam = null;

    setState(() {});
  }

  editParams({ @required int indexX, int indexY}){
    saveStats();

    editingParam = [indexX,indexY];

    if(indexY == null){
      if(editingParam != null && editingParam[0] != null){
        controllerParams.text = paramsList[indexX].name;
      }
    }else
    if(editingParam != null && editingParam[0] != null&& editingParam[1] != null) {
      controllerParams.text =
          paramsList[editingParam[0]].params[editingParam[1]].name;
    }else{
      editingParam = null;
    }
    setState(() {});
  }

  deleteParams(int index){
    try{
      saveStats();
      paramsList.removeAt(index);
      setState(() {

      });
    }catch(e){

    }
  }

  addParam(int index){
    try{
      saveStats();
      paramsList[index].params.add(Param(name: ""));
      setState(() {

      });
    }catch(e){

    }
  }

  deleteParam(int indexX, int indexY){
    try{
      paramsList[indexX].params.removeAt(indexY);
      setState(() {

      });
    }catch(e){}
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

  //todo InitPrice() with InitParamsPrice()

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
    saveParams();
  }

  void load()async{
    item = await getProductForId(widget.id);

    if (item.error == null) {
      updateImagePages();
      _type = item.type;
      _category= item.catPath[0];
      initProperties();
      nameProduct = item.name;
      initParams();
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

    // todo controllerParams ??


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
        centerTitle: true,
        title: GestureDetector(
          onTap: (){saveProduct();},
          child: Container(
            decoration: BoxDecoration(
              color: cDefault,
              borderRadius: BorderRadius.circular(6),

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(widget.edit?"Сохранить изменения":"Добавить", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontStyle: FontStyle.normal, color: cWhite),),
            ),
          ),
        ),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: getIconForId(id: 0, color: c5894bc,),
            )),
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
                  ConstructorParams(),
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
            child: Text("Добавть описание", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
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

  //todo
  Widget ConstructorParamsPrice(){}


  Widget ConstructorParams(){

    Widget editingParams(String hint){
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
                      // maxLength: 50,
                      // maxLengthEnforced: true,

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: cMainText.withOpacity(0.7),
                        ),
                        hintText: hint,
                      ),
                      style: TextStyle(
                          color: Color.fromRGBO(47, 82, 127, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: fontFamily
                      ),
                      controller: controllerParams,
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        saveStats();
                      },
                      child: Container(child: Icon(Icons.check, color: c6287A1, size: 24,))),

                ],
              ),
            ],
          ),
        ),
      );
    }


    Widget nameParams(int index){
      return Container(
        child: (editingParam != null &&editingParam[0] == index && editingParam[1] == null)?editingParams("Название"):Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: (){
                      editParams(indexX: index);
                    },
                    child: Text(paramsList[index].name == ""?"Название":paramsList[index].name, style: TextStyle(color: paramsList[index].name == ""?cPay.withOpacity(0.7):cTitles, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: fontFamily,fontStyle: FontStyle.normal),)),
                SizedBox(width: 8,),
                GestureDetector(
                    onTap: (){
                      addParam(index);
                    },
                    child: Text("+", style: TextStyle(color: cIcons, fontSize: 24),))
              ],
            ),
            GestureDetector(
                onTap: (){
                  deleteParams(index);
                },
                child: getIconForId(id: 8, color: cIcons)),
          ],
        ),
      );
    }
    Widget param(indexX, int indexY){
      return Container(
        child: (editingParam != null &&editingParam[0] == indexX && editingParam[1] == indexY)?editingParams("Значение"):Row(
          children: [
            GestureDetector(
                onTap: (){
                  editParams(indexX: indexX, indexY: indexY);

                },
                child: Text(paramsList[indexX].params[indexY].name == ""?"Значение":paramsList[indexX].params[indexY].name, style: TextStyle(color: paramsList[indexX].params[indexY].name == ""?cPay. withOpacity(0.7):cMainText, fontSize: 16, fontWeight: FontWeight.w400,))),
            SizedBox(width: 8,),
            paramsList[indexX].params.length>2?GestureDetector(
                onTap: (){
                  deleteParam(indexX, indexY);
                },
                child: getIconForId(id: 8, color: cIcons,size: 18)):SizedBox()
          ],
        ),
      );
    }

    Widget buttonAdd(){
      return GestureDetector(
        onTap: (){
          addParams();
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


    Widget generator(){
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Divider(color: cDefault,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(paramsList.length, (index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nameParams(index),
                            Column(

                              children: List.generate(paramsList[index].params.length, (index2) => param(index,index2)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        paramsList.length==0?SizedBox():generator(),
        buttonAdd()
      ],
    );




  }

}
