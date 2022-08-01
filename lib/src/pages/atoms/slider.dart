import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sliders.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class InfoSlide extends StatefulWidget {
  const InfoSlide({Key? key, this.listSliders}) : super(key: key);

  @override
  _InfoSlideState createState() => _InfoSlideState();
  final List<Sliders>? listSliders;
}

class _InfoSlideState extends State<InfoSlide> {
  String reason = '';
  final CarouselController _controller = CarouselController();
  List<Images>? images = [];
  bool? isShowingMainData;

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.listSliders!.length; i++) {
      images = widget.listSliders![1].images!;
    }
    if (images!.isEmpty) {
      return SizedBox();
    } else {
      setState(() {
        images = widget.listSliders![1].images!;
      });
    }
    List<Widget> imageSliders = images!
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

  _content(BuildContext context, Images item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => launch(item.link!),
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
                      Colors.green.withOpacity(0.4), BlendMode.dstOut),
                  image: NetworkImage(item.image!),
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
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        child: Text(
                          // item.description!,
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black54,
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
