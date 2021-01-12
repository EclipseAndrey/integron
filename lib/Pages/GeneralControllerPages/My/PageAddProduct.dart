import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/ViewProduct.dart';
import 'package:integron/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Draft/DraftDB.dart';
import 'package:integron/Utils/DB/Products/Params/Param.dart';
import 'package:integron/Utils/DB/Products/Params/Params.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/DB/Products/Property.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/BottomDialogs/BotomSheetSelectForIndex.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogError.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:integron/REST/Api.dart';
import 'package:http/http.dart' as http;
import 'package:integron/Utils/DB/ImagesProduct.dart';
import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';
import 'package:integron/Utils/fun/Logs.dart';

class AddProductPage extends StatefulWidget {

  bool edit = false;
  bool draft = false;
  int id;
  AddProductPage({this.id,this.edit, this.draft}) : assert(!((edit!= null && draft !=null)&&(edit && draft))) ;


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



  ///=========================== Images ===============================

  PageController controllerImageSlider = PageController();
  List<Widget> imagePages = [];
  List imagelocal = [];
  List<ImageProduct> images = [];


  final picker = ImagePicker();


  ///=========================== Details ==============================

  final pickerDetails = ImagePicker();
  List<Widget> detailsPages = [];
  List<String> detailsUrls = [];
  String detailsHead = "Детали";
  List<ImageProduct> detailsList = [];


  ///=========================== Type =================================

  int _type;


  ///=========================== Category =============================

  Category _category;
  List<Category> categories;


  ///=========================== Name Product =========================

  String nameProductDefault = "Редактировать название";
  String nameProduct =  "";
  String nameProductStep;
  bool editingHeaderState = false;
  TextEditingController controllerHeader = TextEditingController();
  FocusNode focusHeader = FocusNode();


  ///=========================== Properties ===========================

  List<Property> properties =  [Property(name: "Краткое описание", value: "", editingValue: false, canDelete: false),Property(canDelete: false, name: "Полное описание", value:"", editingValue: false)];
  List<Property> propertiesCopy =  [];
  int idEditingProperties;
  Property editingProperty  = Property();
  TextEditingController controllerNameProperty = TextEditingController();
  FocusNode focusNameProperty = FocusNode();
  TextEditingController controllerValueProperty = TextEditingController();
  FocusNode focusValueProperty = FocusNode();
  bool focusPropertiesOne = true;


  ///=========================== Params ===============================

  List<Params> paramsList = [];
  Params paramsStep = Params(name: "");
  List<int> editingParam;
  TextEditingController controllerParams = TextEditingController();
  FocusNode focusParams = FocusNode();


  ///=========================== Price ================================

  String priceTitle = "Цена";
  String priceHintSumm = "Сумма";
  String priceHintUnit = "ед. изм.";
  String priceSummText = "";
  String priceUnitText = "";
  String priceSummTextStep;
  String priceUnitTextStep;
  TextEditingController controllerPriceSumm = TextEditingController();
  FocusNode focusPriceSum = FocusNode();
  TextEditingController controllerPriceUnit = TextEditingController();
  FocusNode focusPriceUnit = FocusNode();
  bool focusOnePrice = true;

  ///=========================== GetCourse ============================

  String accountName = '';
  String productName = '';
  String secretKey = '';
  String accountOfferCode = "";
  TextEditingController controllerAccountName = TextEditingController();
  FocusNode focusAccountName = FocusNode();
  TextEditingController controllerAccountProductName = TextEditingController();
  FocusNode focusProductName = FocusNode();
  TextEditingController controllerAccountSecretKey = TextEditingController();
  FocusNode focusAccountSecretKey = FocusNode();
  TextEditingController controllerAccountOfferCode = TextEditingController();
  FocusNode focusAccountOfferCode = FocusNode();
  bool accountNameEdit = false;
  bool secretKeyEdit = false;
  bool accountOfferCodeEdit = false;



  ///=========================== Service ==============================

  bool loading = true;
  Product item;
  List<String> responsePhoto = [];
  List<String> responseDetails = [];
  bool hasChange = false;

  ///==============================================================================================================================
  ///=========================================================== FUNCTIONS ========================================================
  ///==============================================================================================================================


  ///=========================== Photo ================================

  Future<bool> uploadPhoto (String filename) async {
    String url = Server.relevant+"/"+Api.api+"/uploadPhoto";

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
    await res.stream.transform(utf8.decoder).listen(await(value)async {
      print(value);
      await responsePhoto.add(json.decode(value)['url']);
    });

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

    if(needToSave()){
      List<String> outList = [];
      for(int i = 0; i < imagelocal.length; i++){
        outList.add(imagelocal[i].toString());
      }
      DraftDB.set(images: outList);
    }else{
      hasChange = true;
    }


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

  pop(){
    saveStats();
    if(hasChange){
      showDialogIntegron(
          context: context,
        title: Text(
          "Изменения будут потеряны",
          style:
          TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w600),
        ),
        body: Text(
          "У вас есть несохраненные поля. Хотите сохранить перед выходом?",
          style:
          TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
          textAlign: TextAlign.center,
        ),
        buttons: [
          DialogIntegronButton(
            onPressed: () async{
              closeDialog(context);
              closeDialog(context);

            },
            textButton: Text(
              "Выйти",
              style: TextStyle(
                  color: cLinks, fontSize: 16, fontFamily: fontFamily),
            ),
          ),
          DialogIntegronButton(
            onPressed: () async{
              closeDialog(context);
              checkAndFormProduct();
            },
            textButton: Text(
              "Сохранить",
              style: TextStyle(
                  color: cLinks, fontSize: 16, fontFamily: fontFamily),
            ),
          ),
        ],
      );
    }else{

    }

  }

  ///=========================== Details ==============================

  initDetails(){
    print('init details');
    if(widget.edit){
      detailsList = [];
      try {
        for (int i = 0; i < item.details.length; i++) {
          detailsList.add(ImageProduct(item.details[i], true));
        }
      }catch (e){
        printL("Add product - Init Details = "+e.toString());
      }
    }else{
      detailsList = [];
    }
    updateDetailPages();
  }

  Future<bool> uploadDetail () async {
    String filename;
    String url = Server.relevant+"/"+Api.api+"/uploadPhoto";

    for(int i = 0; i < detailsList.length; i++) {
      print("uploadDetails ${i} ${detailsList[i].net} ${detailsList[i].path}");
      if(!detailsList[i].net){
        filename = detailsList[i].path;
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(
            http.MultipartFile(
                'var_file',
                File(filename).readAsBytes().asStream(),
                File(filename).lengthSync(),
                filename: filename
                    .split("/")
                    .last
            )
        );
        var res = await request.send();



        await res.stream.transform(utf8.decoder).listen(await (value) async {
          print(value);
         // responseDetails.add(json.decode(value)['url']);
         //  detailsList[i].net = true;
         //  detailsList[i].path = json.decode(value)['url'];
          await detailsList.replaceRange(i, i+1, [ImageProduct(json.decode(value)['url'], true)]);
          print("uploadDetails ${i} ${detailsList[i].net} ${detailsList[i].path}");
        });
      }

    }
  }

  updateDetailPages(){
    List<Widget> out = [];
    List<Widget> net=[];

    net = List.generate(detailsList.length, (index) {
      if(detailsList[index].net){
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Image.network(
            detailsList[index].path,
            fit: BoxFit.cover,
          ),
        );
      }else{
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,

          child: Image.file(
            File(detailsList[index].path),
            fit: BoxFit.cover,
          ),
        );
      }
    });

    if(needToSave()){
      DraftDB.set(details: detailsList);
    }

    // if(widget.edit) {
    //   net = List.generate(item.details.length, (index) {
    //     return Container(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.width,
    //       child: Image.network(
    //         item.details[index],
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   });
    //   out.addAll(net);
    // }
    //
    // net = List.generate(detailsLocal.length, (index){
    //   return Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.width,
    //
    //     child: Image.file(
    //       File(detailsLocal[index].toString()),
    //       fit: BoxFit.cover,
    //     ),
    //   );
    // });


    out.addAll(net);

    detailsPages = out;
    setState(() {});
  }

  Future addDetail()async{
    final pickedFile = await pickerDetails.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {

        detailsList.add(ImageProduct(pickedFile.path, false));

        updateDetailPages();

      } else {
        print('No image details selected.');
      }
    });
  }

  deleteDetail(int index){
    detailsList.removeAt(index);
    updateDetailPages();
  }

  upDetail(int index){
    print("updetail");
    try {
      if(index>0) {
        List<ImageProduct> step = [detailsList[index],detailsList[index-1]];
        detailsList.replaceRange(
            index - 1, index+1, step);
      }
    }catch(e){
      printL("Add Product - upDetail error = "+e.toString());
    }
    updateDetailPages();
  }


  ///=========================== Service ==============================

  bool needToSave (){
    if(widget.edit == null || !widget.edit){
      return true;
    }else{
      return false;
    }
  }

  bool dotCheck (String s){
    try{
      double.parse(s);
      return true;
    }catch(e){
      return false;
    }

  }

  bool checkSumm(String s) {




    print(s);
    var stroka = RegExp("^((\d+)\.(\d+))\$");
    // var stroka = RegExp("^([0-9]+).([0-9]+)\$");
    var stroka1 = RegExp("^([0-9]+),([0-9]+)\$");
    var stroka2 = RegExp("^([0-9]+)\$");

    print("==+=="+(dotCheck(s)).toString());
    print("==+==="+(stroka1.hasMatch(s)).toString());
    print("==+===="+(stroka2.hasMatch(s)).toString());
    print("+++++"+(dotCheck(s) || stroka1.hasMatch(s) || stroka2.hasMatch(s)).toString());

    return (dotCheck(s) || stroka1.hasMatch(s) || stroka2.hasMatch(s));
  }

  double initSumReplace(String s){
    var stroka = RegExp("^([0-9]+).([0-9]+)\\\$");
    var stroka1 = RegExp("^([0-9]+),([0-9]+)\\\$");
    var stroka2 = RegExp("^([0-9]+)\\\$");

    print("==+=="+(dotCheck(s)).toString());
    print("==+=="+(stroka1.hasMatch(s)).toString());
    print("==+=="+(stroka2.hasMatch(s)).toString());

    if(dotCheck(s)){
      s = s.replaceFirst(RegExp(','), '.');
      return double.parse(s);
    }else if(stroka1.hasMatch(s)){
      print("=="+s);
       s = s.replaceFirst(RegExp(','), '.');
      print("=="+s);
      return double.parse(s);
    }else if(stroka2.hasMatch(s) ) {
      return int.parse(s).toDouble();
    }

  }

  String setDelivery(){
    if(_type == 2){
      return "0";
    }else{
      return "1";
    }
  }


  void checkAndFormProduct({bool view})async{
    if(imagePages.length == 0){
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

        } else if(checkStudyParams()) {
          {
            // try {
              initSumReplace(priceSummText);
              showDialogLoading(context);
              responsePhoto = [];

              List<ImageProduct> imagesP = [] ;
              List<ImageProduct> imagesD = [] ;

              if(view == null || !view) {
                for (int i = 0; i < imagelocal.length; i++) {
                  await uploadPhoto(imagelocal[i]);
                }
                await uploadDetail();
                detailsUrls = [];
                for (int i = 0; i < detailsList.length; i++) {
                  // ignore: unnecessary_statements
                  detailsList[i].net
                      ? detailsUrls.add(detailsList[i].path)
                      : null;
                  print(detailsList[i].path);
                }
              }else{
                imagesD = detailsList;
                print("details lenght ${imagesD.length}");
                if(widget.edit != null && widget.edit){
                  for(int i = 0; i < item.images.length; i++){
                    imagesP.add(ImageProduct(item.images[i], true));
                  }

                }
                for(int i = 0 ; i < imagelocal.length; i++){
                  imagesP.add(ImageProduct(imagelocal[i].toString(), false));
                }
              }



              if (widget.edit) {
                print("ResponsePhoto " + responsePhoto.length.toString());
                List<String> ststep = []..addAll(item.images)..addAll(
                    responsePhoto);
                responsePhoto = ststep;
                print("ResponsePhoto " + responsePhoto.length.toString());
              }


              propertiesCopy = [];
              print('1property ${properties.length} copy ${propertiesCopy
                  .length}');
              String steptx = properties[1].value;
              String steptxS = properties[0].value;
              propertiesCopy.addAll(properties);
              print('2property ${properties.length} copy ${propertiesCopy
                  .length}');

              properties.removeAt(0);
              properties.removeAt(0);
              print('3property ${properties.length} copy ${propertiesCopy
                  .length}');

              print("-=-=-=-=-=-=-=-=-" + steptx);
              Product productFormForSend = Product(
                images: responsePhoto,
                owner: null,
                name: nameProduct,
                ownerName: null,
                catPath: [],
                text: steptxS,
                fullText: steptx,
                route: widget.edit ? item.route : null,
                price: double.parse(priceSummText),
                type: _type,
                unit: priceUnitText,
                details: detailsUrls,
                delivery: setDelivery(),
                image: null,
                property: properties,
                params: paramsList,
                cat: _category,
                accountName: accountName,
                accountSecretKey: secretKey,
                offerCode: accountOfferCode,
              );
              print('4property ${properties.length} copy ${propertiesCopy
                  .length}');

              properties = [];
              properties.addAll(propertiesCopy);

              setState(() {});

              print('5property ${properties.length} copy ${propertiesCopy
                  .length}');

              if(view == null || !view){
                if (!widget.edit) {
                  addProductR(productFormForSend);
                } else {
                  updateProduct(productFormForSend);
                }
              }else{
                viewProduct(productFormForSend, imagesP, imagesD);
              }

            // } catch (e) {
            //   printL(e);
            // }
          }
        }else{
          dialogErr("Похоже вы не указали параметры аккаунта GetCourse");
        }
      }
    }
  }

  void viewProduct(Product product, List<ImageProduct> listImages, List<ImageProduct> listDetails)async{
    print(product.images.length);
    //todo view
    closeDialog(context);
    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewProductPage(product, listImages, listDetails)));
    print('view product');
  }

  void addProductR(Product product)async{
    Put res = await ProductProvider.forBiz.addProduct(
        product);
    closeDialog(context);
    if (res == null ? 0 : res.error == 200) {
      closeDialog(context);
      dialogErr("Товар успешно добавлен");
      DraftDB.clean();
    } else {
      dialogErr(res.mess);
    }
  }

  void updateProduct(Product product)async{
    Put res = await ProductProvider.forBiz.updateProduct(
        product, widget.id);
    closeDialog(context);
    if (res == null ? 0 : res.error == 200) {
      closeDialog(context);
      dialogErr("Товар успешно изменен");
    } else {
      closeDialog(context);
      dialogErr(res.mess);
    }
  }


  bool checkStudyParams(){
    if(_type == 2){
      if(accountName !="" && secretKey !=""&&accountOfferCode != ''){return true;}else{return false;}

    }else{return true;}
  }

  dialogErr(String text)async{
    await showDialogIntegron(context: context,
        title: Text("Сообщение",  style: TextStyle(color: cMainText, fontSize: 16,fontFamily: fontFamily),),
        body: Text(text,
          style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
          textAlign: TextAlign.center, ));
  }


  ///=========================== Type =================================

  _selectType(int index){
    _type = index;
    if(needToSave()){
      DraftDB.set(type: index);
    }
    setState(() {

    });
  }

  selectType()async{
    List<String> list = ["Товары","Услуги","Обучение"];
    await ShowBottoomSheetSelectForIndex(
      context: context,
      items:list,
      title: "Выберите тип",
      indexSelect: _selectType,
    );
  }


  ///=========================== Category =============================

  _selectCategory(int index){
    _category = categories[index];
    if(needToSave()){
      DraftDB.set(category: categories[index].route);
    }
    setState(() {

    });
  }


  selectCategory()async{
    if(categories == null){
      showDialogLoading(context);
      categories = await CategoryProvider.getCategories();
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


  ///=========================== Params ===============================

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

      ///save to draft
      if(needToSave()){
        if(paramsList == null){
          DraftDB.set(params: []);
        }else{
          DraftDB.set(params: paramsList);
        }
      }

    setState(() {});
  }

  editParams({ @required int indexX, int indexY}){
    saveStats();

    FocusScope.of(context).unfocus();
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
      editParams(indexX: index, indexY: paramsList[index].params.length-1);
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


  ///=========================== Properties ===========================

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
      if (editingProperty != null &&(editingProperty.name != "" && editingProperty.value != "")&&(editingProperty.name != null && editingProperty.value != null)) {
        properties[idEditingProperties] = editingProperty;
      }else {
        if (((properties[idEditingProperties].name == "" && properties[idEditingProperties].value == "")||(properties[idEditingProperties].name == null && properties[idEditingProperties].value == null))&&(idEditingProperties != 0 && idEditingProperties != 1)) {
          deleteProperty(
              idEditingProperties);
        }
      }
      if(needToSave()){
        try {
          DraftDB.set( fullText: properties[1].value, shortText: properties[0].value);
          if(properties.length >1) {
            List<Property> stepProp = [];// properties.getRange(2, properties.length);
            for(int i = 2; i < properties.length; i++){
              stepProp.add(properties[i]);
            }
           DraftDB.set(property: stepProp);
          }else{
            DraftDB.set(property: [] as List<Property>);
          }
        }catch(e){
          printL("Draft set properties error $e");
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
    if(needToSave()){
      try {
        DraftDB.set( fullText: properties[1].value, shortText: properties[0].value);
        if(properties.length >1) {
          List<Property> stepProp = [];// properties.getRange(2, properties.length);
          for(int i = 2; i < properties.length; i++){
            stepProp.add(properties[i]);
          }
          DraftDB.set(property: stepProp);
        }else{
          DraftDB.set(property: [] as List<Property>);
        }
      }catch(e){
        printL("Draft set properties error $e");
      }
    }

  }

  editProperty(int index){
    print("edit p");

    saveStats();


    idEditingProperties = index;


    editingProperty = Property(name:properties[index].name, value: properties[index].value, editingName:properties[index].editingName, editingValue: properties[index].editingValue,canDelete: properties[index].canDelete );
    controllerNameProperty.text = properties[index].name;
    controllerValueProperty.text = properties[index].value;
    setState(() {

    });
  }

  ///=========================== Header ===============================

  editHeader(){

    saveStats();

    controllerHeader.text = nameProduct;
    editingHeaderState = true;
    setState(() {});


  }

  saveHeader(){
    if(nameProductStep != "" && nameProductStep != null){
      nameProduct = nameProductStep;
      if(needToSave()){
        DraftDB.set(name: nameProductStep);
      }
      editingHeaderState = false;
    }else{
      editingHeaderState = false;
    }
    setState(() {});
  }

  ///=========================== Price ================================

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
      if(needToSave()){
        DraftDB.set(unit: priceUnitText, price: priceSummText);
      }
    }
    priceSummTextStep = null;
    priceUnitTextStep = null;
    setState(() {});

  }


  ///=========================== GetCourse ============================

  saveAccountSecretKey(){
    secretKeyEdit = false;
    setState(() {});
  }

  saveAccountName(){
    accountNameEdit = false;
    setState(() {});
  }

  saveAccountOfferCode(){
    accountOfferCodeEdit = false;
    setState((){});
  }

  editAccountSecretKey(){
    saveStats();
    secretKeyEdit = true;
    setState(() {});

  }

  editAccountName(){
    saveStats();
    accountNameEdit = true;
    setState(() {});

  }

  editAccountOfferCode(){
    saveStats();
    accountOfferCodeEdit = true;
    setState((){});


  }




  ///=========================== Service ==============================

  saveStats(){
    saveHeader();
    savePrice();
    saveProperty();
    saveParams();
    saveAccountName();
    saveAccountSecretKey();
    saveAccountOfferCode();
  }

  void load()async{
    item = await ProductProvider.getProduct(widget.id);

    if (item.errors == null) {
      updateImagePages();
      _type = item.type;
      try {
        _category = item.catPath[0];
      }catch(e){print(e);}
      properties =  [Property(name: "Краткое описание", value: item.text, editingValue: false, canDelete: false),Property(canDelete: false, name: "Полное описание", value: item.fullText, editingValue: false)];
      initProperties();
      priceUnitText = item.unit;
      priceSummText = item.price.toString();
      nameProduct = item.name;
      initParams();
      initDetails();
      if(_type == 2){

        accountOfferCode = item.offerCode??"";
        controllerAccountOfferCode.text=accountOfferCode;
        accountName = item.accountName??"";
        controllerAccountName.text = accountName;
        secretKey = item.accountSecretKey??"";
        controllerAccountSecretKey.text = secretKey;
      }

    }
    loading= false;
    setState(() {});
    hasChange = false;
  }

  loadFromDraft()async{
    printL('load from draft');

    if(await DraftDB.isEmpty()){
      widget.draft = false;
    }else{
      Map<String,dynamic> draft = await DraftDB.get();

      ///инициализация category
      if(draft[DraftTable.category] != null){
        List<Category> categoriesStep = await CategoryProvider.getCategories();
        if(categoriesStep != null) {
          for (int i = 0; i < categoriesStep.length; i++) {
            if(categoriesStep[i].route == draft[DraftTable.category]){
              _category = categoriesStep[i];
            }
          }
        }
      }
      ///инициализация type
      if(draft[DraftTable.type] != null){
        _type = draft[DraftTable.type];


        if(_type == 2){
          if(draft[DraftTable.accountName] != null){
            accountName = draft[DraftTable.accountName];
            controllerAccountName.text  = accountName;
          }
          if(draft[DraftTable.accountSecretKey] != null){
            secretKey = draft[DraftTable.accountSecretKey];
            controllerAccountSecretKey.text = secretKey;
          }
          if(draft[DraftTable.offerCode] != null){
            accountOfferCode = draft[DraftTable.offerCode];
            controllerAccountOfferCode.text = accountOfferCode;
          }
        }



      }
      /// инициализация shortDesc
      if(draft[DraftTable.shortText]!=null){
        print("short text "+draft[DraftTable.shortText]);
        print("full text "+draft[DraftTable.fullText]);

        properties =  [Property(name: "Краткое описание", value: draft[DraftTable.shortText], editingValue: false, canDelete: false)];
      }else{
        properties = [Property(name: "Краткое описание", value: "", editingValue: false, canDelete: false)];
      }
      /// инициализация fullDesc
      if(draft[DraftTable.fullText] != null){
        properties.add(Property(canDelete: false, name: "Полное описание", value: draft[DraftTable.fullText], editingValue: false));
      }else{
        properties.add(Property(canDelete: false, name: "Полное описание", value: "", editingValue: false));
      }
      /// инициализация properties
      if(draft[DraftTable.property] != null){
        List<Property> stepProp = draft[DraftTable.property];
        //         // properties.addAll(stepProp);
        for(int i = 0; i < stepProp. length; i ++){
          properties.add(stepProp[i]);
        }
      }
      /// инициализация unit
      if(draft[DraftTable.unit] != null){
        priceUnitText = draft[DraftTable.unit];
      }
      /// инициализация price
      if(draft[DraftTable.price] != null){
        priceSummText = draft[DraftTable.price];
      }
      /// инициализация nameProduct
      if(draft[DraftTable.name] != null){
        nameProduct = draft[DraftTable.name];
      }
      /// инициализация params
      if(draft[DraftTable.params] != null){
        paramsList = draft[DraftTable.params];
      }
      /// инициализация details
      if(draft[DraftTable.details] != null){
        detailsList = draft[DraftTable.details];
        updateDetailPages();
      }
      /// инициализация images
      if(draft[DraftTable.images] != null){
        imagelocal = draft[DraftTable.images];
        updateImagePages();
      }
    }
    loading= false;
    setState(() {});


  }

  @override
  void initState() {

    controllerValueProperty.addListener(() {
      editingProperty.value = controllerValueProperty.text;
      hasChange = true;
    });
    controllerNameProperty.addListener(() {
      editingProperty.name = controllerNameProperty.text;
      hasChange = true;

    });
    controllerHeader.addListener(() {
      nameProductStep = controllerHeader.text;
      hasChange = true;

    });
    controllerPriceUnit.addListener(() {
      priceUnitTextStep = controllerPriceUnit.text;
      hasChange = true;

    });
    controllerPriceSumm.addListener(() {
        priceSummText = controllerPriceSumm.text;
        hasChange = true;

    });

    controllerAccountName.addListener(() {
      accountName = controllerAccountName.text;
      hasChange = true;

      if(needToSave()){
        DraftDB.set(accountName: accountName??"");
      }
    });

    controllerAccountSecretKey.addListener(() {
      secretKey = controllerAccountSecretKey.text;
      hasChange = true;

      if(needToSave()){
        DraftDB.set(accountSecretKey: secretKey??"");
      }
    });
    controllerAccountOfferCode.addListener(() {
      accountOfferCode = controllerAccountOfferCode.text;
      hasChange = true;

      if(needToSave()){
        DraftDB.set(offerCode: accountOfferCode??"");
      }
    });

    if(widget.edit == null && !widget.edit) {
      loading = false;
      setState(() {

      });
    }else if (widget.draft!= null && widget.draft){
      loadFromDraft();
    }else{
      load();
    }
    super.initState();
  }


  ///==============================================================================================================================
  ///=========================================================== PAINT ============================================================
  ///==============================================================================================================================

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        print('on will ok');
        if(hasChange)saveStats();
        if(hasChange && widget.edit !=null && widget.edit){pop();}else{
          closeDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: loading?Text("Загрузка", style: TextStyle(
              color: cMainText.withOpacity(0.7),
              fontSize: 24,
              fontFamily: fontFamily)):GestureDetector(
            onTap: (){
              saveStats();
              checkAndFormProduct();
              },
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
                if(hasChange)saveStats();
                if(hasChange && widget.edit !=null && widget.edit){
                  pop();
                }else {
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: getIconSvg(id: 0, color: c5894bc,),
              )),
          actions: [
            GestureDetector(
                onTap: (){
                  checkAndFormProduct(view: true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: getIconSvg(id: IconsSvg.eye, color: c5894bc,),
                )),
          ],


          backgroundColor: cBG,
          elevation: 0,
        ),
        body: Content(),
      ),
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
                  _type == 2?ParamsStudy():SizedBox(),

                  SizedBox(height: 6,),

                ],
              ),
            ),
            DetailsConstructor(),


          ],
        ),
      ),
    );
  }




  ///=========================== Properties ===========================

  Widget editContainer(){

    if(focusPropertiesOne) {
      focusPropertiesOne = false;


      if (!(properties[idEditingProperties].editingValue == null) && (properties[idEditingProperties].editingValue )) {
        print("Фокус на имя параметра");

        FocusScope.of(context).requestFocus(focusNameProperty);
      } else {
        print("Фокус на значение параметра");


        FocusScope.of(context).requestFocus(focusValueProperty);
      }
    }

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
                        focusNode: focusNameProperty,
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
                    focusNode: focusValueProperty,
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

  Widget ConstructorProperty(){

    Widget buttonAdd(){
      return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          focusPropertiesOne = true;
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
                //todo focus
                 FocusScope.of(context).unfocus();
                focusPropertiesOne = true;
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
                                properties[index].value == ""?"Нажмите для редактирования":properties[index].value,
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
                              child: getIconSvg(id: 8, color: c6287A1)),
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


  ///=========================== Images ===============================

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
                      child: getIconSvg(id: 22, color: cWhite, size: 24),
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
                        child: getIconSvg(id: 8, color: cWhite, size: 24),
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

  ///=========================== Categories ===========================

  Widget CategorySelect(){


    String typeWord(int type){
      if(type == 0){return "Товары";}else if(type == 1){return "Услуги";}else if(type == 2){return "Обучение";}else{return "Выберите тип";}
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
                    getIconSvg(id: 38, size: 12, color: c6287A1),
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
                    getIconSvg(id: 38, size: 12, color: c6287A1),
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
                    getIconSvg(id: 38, size: 12, color: c6287A1),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }


  ///=========================== Header ===============================

  Widget EditHeader(){
    FocusScope.of(context).requestFocus(focusHeader);

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
                    focusNode: focusHeader,
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
              child: Text(nameProduct == ""?nameProductDefault:nameProduct, style: TextStyle(color: Color.fromRGBO(88,148,188,1), fontSize:  24, fontFamily:  fontFamily, fontWeight:  FontWeight.w400, fontStyle:  FontStyle.normal),)),
        ],
      ),
    );

  }

  ///=========================== Price ================================

  Widget Price(){

    Widget priceStateSave(){
      return GestureDetector(
        onTap: (){
          focusOnePrice = true;
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
    Widget priceEditSate(){

      if(focusOnePrice) {
        focusOnePrice = false;
        if (!(controllerPriceSumm.text != null &&
            controllerPriceSumm.text.isNotEmpty)|| ((controllerPriceUnit.text != null) && controllerPriceUnit.text.isNotEmpty)) {
          FocusScope.of(context).requestFocus(focusPriceSum);
        } else {
          FocusScope.of(context).requestFocus(focusPriceUnit);

        }
      }

      return Container(

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
                      focusNode: focusPriceSum,
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
                      focusNode: focusPriceUnit,
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

    return priceUnitTextStep==null?priceStateSave():priceEditSate();


  }

  ///=========================== Params ===============================

  Widget ConstructorParams(){

    Widget editingParams(String hint){

      FocusScope.of(context).requestFocus(focusParams);

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

                      focusNode: focusParams,
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
                      FocusScope.of(context).unfocus();
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
                child: getIconSvg(id: 8, color: cIcons)),
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
                  FocusScope.of(context).unfocus();
                  editParams(indexX: indexX, indexY: indexY);

                },
                child: Text(paramsList[indexX].params[indexY].name == ""?"Значение":paramsList[indexX].params[indexY].name, style: TextStyle(color: paramsList[indexX].params[indexY].name == ""?cPay. withOpacity(0.7):cMainText, fontSize: 16, fontWeight: FontWeight.w400,))),
            SizedBox(width: 8,),
            paramsList[indexX].params.length>2?GestureDetector(
                onTap: (){
                  deleteParam(indexX, indexY);
                },
                child: getIconSvg(id: 8, color: cIcons,size: 18)):SizedBox()
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

  ///=========================== GetCourse ============================

  Widget editStudy(TextEditingController controller,  String head, String hint, int focusNode){

    FocusScope.of(context).requestFocus(focusNode == 0?focusAccountName:focusNode == 1?focusAccountSecretKey:focusAccountOfferCode);


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
                    Text(
                      head,
                      style: TextStyle(color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                    ),
                    GestureDetector(
                        onTap: (){
                          saveStats();
                          },
                        child: Container(child: Icon(Icons.check, color: c6287A1, size: 24,))),

                  ],
                ),
                Container(
                  //width: MediaQuery.of(context).size.width-24-10,
                  child: TextField(
                    focusNode: (focusNode == 0?focusAccountName:focusNode == 1?focusAccountSecretKey:focusAccountOfferCode),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(153, 155, 158, 1),
                      ),
                      hintText: hint,
                    ),
                    style: TextStyle(
                        color: cMainText,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily
                    ),
                    controller: controller,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget ParamsStudy(){
    return Column(
      children: [
        Divider(color: cDefault, ),

        accountNameEdit? editStudy(controllerAccountName, "Имя аккаунта GetCourse", "Имя", 0):GestureDetector(
          onTap:(){
            editAccountName();
            // FocusScope.of(context).requestFocus(focusAccountName);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.90,
                    child: Text(
                      "Имя аккаунта GetCourse",
                      style: TextStyle(
                          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                    ),
                  ),
                  SizedBox(height:  4,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.90,

                    child: Text(
                      accountName == ""?"Нажмите для редактирования":accountName,
                      style: TextStyle(
                          color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Divider(color: cDefault, ),

        secretKeyEdit? editStudy(controllerAccountSecretKey, "Ключ аккаунта", "Ключ", 1):GestureDetector(
          onTap: (){
            editAccountSecretKey();
            // FocusScope.of(context).requestFocus(focusAccountSecretKey);

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.90,
                    child: Text(
                      "Секретный ключ аккаунта",
                      style: TextStyle(
                          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                    ),
                  ),
                  SizedBox(height:  4,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.90,

                    child: Text(
                      secretKey == ""?"Нажмите для редактирования":secretKey,
                      style: TextStyle(
                          color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Divider(color: cDefault, ),

        accountOfferCodeEdit? editStudy(controllerAccountOfferCode, "Код предложения", "Код", 2):GestureDetector(
          onTap: (){
            editAccountOfferCode();
            // FocusScope.of(context).requestFocus(focusAccountOfferCode);

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.90,
                    child: Text(
                      "Код предложкния",
                      style: TextStyle(
                          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
                    ),
                  ),
                  SizedBox(height:  4,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.90,

                    child: Text(
                      accountOfferCode == ""?"Нажмите для редактирования":accountOfferCode,
                      style: TextStyle(
                          color: cMainText, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }

  ///=========================== Details ==============================

  Widget DetailsConstructor(){

    Widget head = Text(
      detailsHead,
      style: TextStyle(
          color: c2f527f, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );

    Widget generatorDetails(){
      if(detailsPages.length == 0) {
        return SizedBox();
      }else{
        return Column(
          children:
            List.generate(detailsPages.length, (index) {
              return Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: detailsPages[index],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: (){
                            upDetail(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cDefault,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: getIconSvg(id: IconsSvg.moveTop, color: cWhite),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding:  EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: (){
                            deleteDetail(index);
                          },
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                color: cDefault
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(6),
                                child: getIconSvg(id: IconsSvg.close),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ,
        );
      }
    }

    Widget addDetailButton(){
      return Center(
        child: InkWell(
          onTap: (){addDetail();},
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(6),
            // padding: EdgeInsets.all(12),
            dashPattern: [12],
            color: cd1d3d7,
            child: Container(
              width: MediaQuery.of(context).size.width-24,
              height: MediaQuery.of(context).size.width-24,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getIconSvg(id: IconsSvg.image, color: cIcons),
                    Text('Добавить изображение', style: TextStyle(color: cTitles, fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: cDefault,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: head,
        ),
        SizedBox(height: 6,),
        generatorDetails(),
        SizedBox(height: 12,),
        addDetailButton(),
      ],
    );


  }





}
