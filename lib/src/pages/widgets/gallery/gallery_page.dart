import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({
    Key? key,
  }) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String reason = '';
  final CarouselController _controller = CarouselController();
  final CarouselController _controller1 = CarouselController();
  final CarouselController _controller2 = CarouselController();
  final CarouselController _controller3 = CarouselController();
  Gallery? gallery;
  List<General>? general = [];
  List<Projects>? projects = [];
  List<Programs>? programs = [];
  List<Sites>? sites = [];
  List<Widget>? imageSliders;
  List<Widget>? imageSliders1;
  List<Widget>? imageSliders2;
  List<Widget>? imageSliders3;

  bool? isShowingMainData;
  @override
  void initState() {
    loadGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          if (gallery == null) ...[
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ] else ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'General',
                  style: TextStyle(
                      fontSize: 23,
                      color: verdePrincipal,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),

                Stack(
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
                          autoPlayInterval: Duration(seconds: 5),
                        ),
                        carouselController: _controller,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Proyectos.',
                  style: TextStyle(
                      fontSize: 23,
                      color: verdePrincipal,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),

                Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: CarouselSlider(
                        items: imageSliders1,
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 7,
                            onPageChanged: onPageChange,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 7),
                            reverse: true),
                        carouselController: _controller1,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Programas',
                  style: TextStyle(
                      fontSize: 23,
                      color: verdePrincipal,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),

                Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: CarouselSlider(
                        items: imageSliders2,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 7,
                          onPageChanged: onPageChange,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 6),
                        ),
                        carouselController: _controller2,
                      ),
                    ),
                  ],
                ),
                // Text(
                //   'Sitios turisticos',
                //   style: TextStyle(
                //       fontSize: 23,
                //       color: verdePrincipal,
                //       fontWeight: FontWeight.w700,
                //       fontStyle: FontStyle.italic),
                // ),
                // SizedBox(height: 10),
                // Stack(
                //   fit: StackFit.loose,
                //   children: <Widget>[
                //     Container(
                //       width: double.infinity,
                //       child: CarouselSlider(
                //         items: imageSliders3,
                //         options: CarouselOptions(
                //           enlargeCenterPage: true,
                //           aspectRatio: 16 / 7,
                //           onPageChanged: onPageChange,
                //           autoPlay: true,
                //         ),
                //         carouselController: _controller,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ],
      ),
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
      // onTap: () => launch(item!.route!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.86,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.green.withOpacity(0.4), BlendMode.dstOut),
                  image: NetworkImage(item.route!),
                ),
                borderRadius: BorderRadius.circular(15.0),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomLeft,
                //     end: Alignment.topRight,
                //     colors: <Color>[
                //       moradoGradiendSlide,
                //       rosaGradiendslide,
                //     ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(50),
                    //             bottomRight: Radius.circular(50))),
                    //     child: Text(
                    //       // item.description!,
                    //       '',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.grey[900],
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w800,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(50),
                    //             bottomLeft: Radius.circular(50))),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         color: Colors.black54,
                    //       ),

                    //       // size: 35,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentProject(BuildContext context, Projects item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => launch(item!.route!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.86,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.green.withOpacity(0.4), BlendMode.dstOut),
                  image: NetworkImage(item.coverImage!),
                ),
                borderRadius: BorderRadius.circular(15.0),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomLeft,
                //     end: Alignment.topRight,
                //     colors: <Color>[
                //       moradoGradiendSlide,
                //       rosaGradiendslide,
                //     ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(50),
                    //             bottomRight: Radius.circular(50))),
                    //     child: Text(
                    //       // item.description!,
                    //       '',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.grey[900],
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w800,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(50),
                    //             bottomLeft: Radius.circular(50))),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         color: Colors.black54,
                    //       ),

                    //       // size: 35,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentPrograms(BuildContext context, Programs item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => launch(item!.route!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.86,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.green.withOpacity(0.4), BlendMode.dstOut),
                  image: NetworkImage(item.coverImage!),
                ),
                borderRadius: BorderRadius.circular(15.0),
                // gradient: LinearGradient(
                //     begin: Alignment.bottomLeft,
                //     end: Alignment.topRight,
                //     colors: <Color>[
                //       moradoGradiendSlide,
                //       rosaGradiendslide,
                //     ]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(50),
                    //             bottomRight: Radius.circular(50))),
                    //     child: Text(
                    //       // item.description!,
                    //       '',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.grey[900],
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w800,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(50),
                    //             bottomLeft: Radius.circular(50))),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         color: Colors.black54,
                    //       ),

                    //       // size: 35,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentSites(BuildContext context, Sites item) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => launch(item!.route!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.86,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.green.withOpacity(0.4), BlendMode.dstOut),
                  image: NetworkImage(item.files!.path!),
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
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(5.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(50),
                    //             bottomRight: Radius.circular(50))),
                    //     child: Text(
                    //       // item.description!,
                    //       '',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         color: Colors.grey[900],
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w800,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white60,
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(50),
                    //             bottomLeft: Radius.circular(50))),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       child: Icon(
                    //         Icons.arrow_forward_rounded,
                    //         color: Colors.black54,
                    //       ),

                    //       // size: 35,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadGallery() async {
    Uri url = Uri.parse(Constants.url + 'app-gallery');
    var response = await http.get(url);

    if (this.mounted) {
      print('_loadGallery');
      Map<String, dynamic> map = json.decode(response.body);
      var data = map["data"];
      setState(
        () {
          gallery = Gallery.fromJson(data);
          general = gallery!.general!;
          projects = gallery!.projects!;
          programs = gallery!.programs!;
        },
      );
    }
    imageSliders = general!
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
    imageSliders1 = projects!
        .map(
          (item) => Container(
            child: Container(
                decoration: BoxDecoration(
                    // color: HexColor('#2E78EF'),
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    _contentProject(context, item),
                  ],
                )),
          ),
        )
        .toList();
    imageSliders2 = programs!
        .map(
          (item) => Container(
            child: Container(
                decoration: BoxDecoration(
                    // color: HexColor('#2E78EF'),
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    _contentPrograms(context, item),
                  ],
                )),
          ),
        )
        .toList();

    imageSliders3 = sites!
        .map(
          (item) => Container(
            child: Container(
                decoration: BoxDecoration(
                    // color: HexColor('#2E78EF'),
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    _contentSites(context, item),
                  ],
                )),
          ),
        )
        .toList();
  }
}
