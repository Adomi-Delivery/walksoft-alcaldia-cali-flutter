import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sliders.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class SliderHome extends StatefulWidget {
  const SliderHome({Key? key, this.listSliders}) : super(key: key);

  @override
  _SliderHomeState createState() => _SliderHomeState();
  final List<Sliders>? listSliders;
}

class _SliderHomeState extends State<SliderHome> {
  String reason = '';
  final CarouselController _controller = CarouselController();
  bool? isShowingMainData;
  @override
  Widget build(BuildContext context) {
    List<Images>? images;
    for (var i = 0; i < widget.listSliders!.length; i++) {
      images = widget.listSliders![0].images!;
    }
    if (images == null) {
      return SizedBox();
    }
    List<Widget> imageSliders = images
        .map(
          (item) => Container(
            child: Container(
                decoration: BoxDecoration(
                    // color: HexColor('#2E78EF'),
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    _content(context, item),
                  ],
                )),
          ),
        )
        .toList();
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 16 / 7,
              onPageChanged: onPageChange,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 8),
            ),
            carouselController: _controller,
          ),
        ),
      ],
    );
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  _content(BuildContext context, Images item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            height: size.height * 0.20,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: amarilloTarjeta,
            ),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8, left: 15),
                  child: Text(item.description!,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                )),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: size.height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[400],
              image: DecorationImage(
                image: NetworkImage(item.image!),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            // child: Image.network(item.image!),
          ),
          Positioned(
            top: 5,
            right: 2,
            child: Card(
              child: CircleAvatar(
                maxRadius: 20.0,
                backgroundColor: amarilocircleTarjeta,
                child: Image.asset(
                  'assets/lamp.png',
                  height: 50,
                ),
              ),
              elevation: 18.0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Positioned(
            bottom: 10,
            right: 2,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: MaterialButton(
                textColor: blanco,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(7)),
                color: verdeBottom,
                onPressed: () => launch(item.link!),
                child: Row(
                  children: [
                    Text(
                      'Más Info',
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
