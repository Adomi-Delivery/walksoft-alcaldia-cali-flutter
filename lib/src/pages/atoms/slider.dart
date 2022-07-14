import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class InfoSlide extends StatefulWidget {
  @override
  _InfoSlideState createState() => _InfoSlideState();
}

class _InfoSlideState extends State<InfoSlide> {
  String reason = '';
  final CarouselController _controller = CarouselController();
  bool? isShowingMainData;
  final List<String> imgList = [
    'Nueva Propuesta',
    'Pague Predial',
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
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
              aspectRatio: 16 / 6,
              onPageChanged: onPageChange,
              autoPlay: true,
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

  _content(BuildContext context, item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.86,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.green.withOpacity(0.7), BlendMode.dstOut),
                  image: AssetImage(
                    'assets/slide.png',
                  ),
                ),
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      moradoGradiendSlide,
                      rosaGradiendslide,
                    ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -1,
                      top: 1,
                      bottom: 1,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        child: CircleAvatar(
                          backgroundColor: blanco,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.grey[700],
                          ),

                          // size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
