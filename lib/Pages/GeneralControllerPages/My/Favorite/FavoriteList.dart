import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:integron/Utils/IconDataForCategory.dart';



class FavoriteList extends StatefulWidget {
  List<Product> list;
  Function () _isEmpty;
  FavoriteList(this.list, this._isEmpty);




  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  SlidableController slidableController;
  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  @override
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => item(widget.list[index], index),
      ),
    );
  }


  Widget item(Product product, int index){

    Widget _name(){
      return Text(product.name, overflow: TextOverflow.ellipsis, style: TextStyle(color:  cMainText, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),);
    }
    Widget _owner(){
      return Text(product.ownerName, overflow: TextOverflow.ellipsis, style: TextStyle(color:  cPlaceHolder, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),);

    }
    Widget _price(){
      return Row(
        children: [
          Text(product.price.toString(), style: TextStyle(color: cButtons, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600,fontSize: 16,fontFamily: fontFamily,),),
          Text(" DEL", style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600,fontSize: 14,fontFamily: fontFamily,),),
          Text(" / "+product.unit, style: TextStyle(color: cDefault, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400,fontSize: 14,fontFamily: fontFamily,),),
        ],
      );

    }



    print('item generate');
    return  Slidable(
      key: Key(product.name),
      
      controller: slidableController,
      direction: Axis.horizontal,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) async{

            widget.list.removeAt(index);
            setState(() {});
            await ProductProvider.setFavorite(product.route, false);
            if(widget.list.length == 0)widget._isEmpty();
            setState(() {});
        },
      ),
      actionPane: _getActionPane(1),
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(product.route)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 100,
                  width: 100,
                  child: Image.network(widget.list[index].image, fit: BoxFit.cover,
                  ),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _name(),
                  SizedBox(height: 3,),
                  _owner(),
                  SizedBox(height: 3,),

                  _price(),
                ],
              )

            ],
          ),
        ),
      ),
      actions: <Widget>[

      ],
      secondaryActions: <Widget>[

        IconSlideAction(
          caption: 'Поделиться',
          color: cDefault,
          iconWidget: getIconSvg(id: IconsSvg.share, color: cWhite),
          onTap: () => (){},
          closeOnTap: true,
        ),
        IconSlideAction(
          caption: 'Delete',

          color: cPay,
          icon: Icons.delete,
          onTap: ()async{
            print("tap");
            widget.list.removeAt(index);
            setState(() {});
            await ProductProvider.setFavorite(product.route, false);
            if(widget.list.length == 0)widget._isEmpty();
            setState(() {});



          },
        ),
      ],
    );
  }


  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }
}
