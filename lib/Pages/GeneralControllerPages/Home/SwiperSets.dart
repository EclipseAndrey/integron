import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Utils/DB/Items/Set.dart';

class SwiperSets extends StatefulWidget {
  List<SetBloc> list;
  double minusFontSize;
  SwiperSets(this.list, this.minusFontSize);

  @override
  _SwiperSetsState createState() => _SwiperSetsState();
}

class _SwiperSetsState extends State<SwiperSets> {

  SwiperController controller = SwiperController();
  int indexPage = 0;
  @override

  void initState() {
    controller.startAutoplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,

            child: Swiper(
              onIndexChanged: (ind){
                indexPage = ind;
                setState(() {

                });
              },
              itemBuilder: (BuildContext context,int index){
                return new Image.network(widget.list[index].image,fit: BoxFit.cover,);
              },
              autoplay: true,
              autoplayDelay: 3000,
              autoplayDisableOnInteraction: true,
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 34),
              child: Text(widget.list[indexPage].name, style: TextStyle(color: Colors.white, fontSize: 16 -widget.minusFontSize, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontFamily: fontFamily),),
            ),
          ),
        ],
      ),
    );
  }
}
