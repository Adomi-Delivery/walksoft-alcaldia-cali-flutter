import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/developmentPlan.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/featured_projects.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sliders.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/custom_dialog.dart';

import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/slider.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/slider_home.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/maps/maps_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeaturedProjects> listCardProjects = [];
  List<Sliders> listSliders = [];
  List<DevelopmentPlan> planList = [];
  @override
  void initState() {
    _loadInfoCard();
    _loadInfoSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          SafeArea(
            child: SizedBox(
              height: size.height * 0.02,
            ),
          ),
          _createDevelopmentPlan(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.02,
            ),
          ),
          Text(
            'Programas y proyectos.',
            style: TextStyle(
                fontSize: 20,
                color: verdePrincipal,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic),
          ),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.02,
            ),
          ),
          _createCardProjects(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.02,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'ListadoProyectos');
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: verdePrincipal,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Ver todos los proyectos ',
                      style: TextStyle(
                        fontSize: 23,
                        color: blanco,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: blanco,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: verdePrincipal,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.04,
            ),
          ),
          InfoSlide(
            listSliders: listSliders,
          ),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          createCardNews(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.03,
            ),
          ),
          // SafeArea(
          //   child: SizedBox(
          //     height: size.height * 0.01,
          //   ),
          // ),
          // createCardNews(context),
          // SafeArea(
          //   child: SizedBox(
          //     height: size.height * 0.01,
          //   ),
          // ),
          // SafeArea(
          //   child: SizedBox(
          //     height: size.height * 0.01,
          //   ),
          // ),
          // createCardNews(context),
          // SafeArea(
          //   child: SizedBox(
          //     height: size.height * 0.06,
          //   ),
          // ),
          _createGallery(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
        ]),
      ),
      bottomNavigationBar: createBottomAppBar(0, context),
    );
  }

  _loadInfoSliders() async {
    try {
      Uri url = Uri.parse(Constants.url + 'sliders');
      var response = await http.get(url);
      List? listJsonDecode = jsonDecode(response.body.toString());
      if (this.mounted) {
        print('_loadInfoSliders');
        setState(() {
          listSliders = listJsonDecode!
              .map((mapProjects) => new Sliders.fromJson(mapProjects))
              .toList();
        });
      }
      return listSliders;
    } catch (e) {
      _loadInfoSliders();
    }
  }

  _createDevelopmentPlan(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliderHome(
      listSliders: listSliders,
    );
  }

  _loadInfoCard() async {
    try {
      Uri url = Uri.parse(Constants.url + 'featured-projects');
      // Uri url = Uri.parse(Constants.url + 'projects-and-programs');
      var response = await http.get(url);

      if (this.mounted) {
        print('_loadInfoCard');
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["data"];
        setState(() {
          listCardProjects = data
              .map((mapProjects) => new FeaturedProjects.fromJson(mapProjects))
              .toList();
        });

        // List? listJsonDecode = jsonDecode(response.body.toString());
        // if (this.mounted) {
        //   setState(() {
        //     listCardProjects = listJsonDecode!
        //         .map(
        //             (mapProjects) => new FeaturedProjects.fromJson(mapProjects))
        //         .toList();
        //   });
        // }
        // return listCardProjects;
      }

      return listCardProjects;
    } catch (e) {
      _loadInfoCard();
    }
  }

  _createCardProjects(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.30,
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          children: List.generate(listCardProjects.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InfoProjectPage(
                      idProject: listCardProjects[index].id.toString(),
                    ),
                  ),
                );
                // Navigator.pushNamed(context, 'InfoProyecto',
                //     arguments: listCardProjects[index].id.toString());
              },
              child: Container(
                height: size.height * 0.10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        blanco,
                        gris,
                      ]),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        listCardProjects[index].name!,
                        style: TextStyle(
                            fontSize: 15,
                            color: verdePrincipal,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      right: -55,
                      child: ClipOval(
                        child: Image.network(
                          listCardProjects[index].coverImage!,
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: verdePrincipal,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: blanco,
                          ),
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }

  createCardNews(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, 'NoticePage');
          Navigator.pushNamed(context, 'NoticePage');
        },
        child: Container(
          height: size.height * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                color: Colors.grey[300]!,
                offset: Offset(1, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.teal.withOpacity(0.7),
                  child: Icon(
                    Icons.article_rounded,
                    color: blanco,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Noticias',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(
                        height: 5,
                      ),
                      Text(
                        'Enero - 15 - 2021',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createGallery(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'sites'),
          child: Container(
              height: size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    amarilloGallery,
                    naranjaGallery,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    color: Colors.grey[300]!,
                    offset: Offset(1, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/camera.png',
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sitios de interés',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.lightBlue[900],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            height: 5,
                          ),
                          Text(
                            'Santiago de Cali',
                            style: TextStyle(
                              fontSize: 13,
                              color: blanco,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    amarilloGallery,
                    naranjaGallery,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    color: Colors.grey[300]!,
                    offset: Offset(1, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/camera.png',
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Galeria de Fotos',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.lightBlue[900],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(
                            height: 5,
                          ),
                          Text(
                            'Santiago de Cali',
                            style: TextStyle(
                              fontSize: 13,
                              color: blanco,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        SizedBox(
          height: size.height * 0.08,
        ),
        Container(
          height: size.height * 0.60,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width * 0.44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/Image.png',
                      ),
                    )),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: Container(
                  height: size.height * 0.35,
                  width: size.width * 0.44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/Image1.png',
                        ),
                      )),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  height: size.height * 0.22,
                  width: size.width * 0.44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/Image2.png',
                        ),
                      )),
                ),
              ),
              Positioned(
                left: 1,
                bottom: 1,
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/Image3.png',
                        ),
                      )),
                ),
              ),
              Positioned(
                left: 1,
                bottom: 100,
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/Image4.png',
                        ),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _launchURL() async {
    Uri url = Uri.parse(Constants.url + 'development-plan');
    // var response = await http.get(url, headers: headers);

    String token = '';

    final data = await http.get(url, headers: {'Authorization': token});
    print(data.request);
    String jsonComplete = "[" + data.body.toString();
    jsonComplete = jsonComplete + "]";
    final decodedData = json.decode(jsonComplete);

    for (var item in decodedData) {
      DevelopmentPlan plan = DevelopmentPlan.fromJson(item);

      planList.add(plan);
    }

    String urlGo = planList[0].url!;
    launch(urlGo);
  }
}
