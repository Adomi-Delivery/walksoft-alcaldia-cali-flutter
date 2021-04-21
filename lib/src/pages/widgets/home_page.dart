import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/developmentPlan.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/featured_projects.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/slider.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/list_projects_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeaturedProjects> listCardProjects = [];
  List<DevelopmentPlan> planList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: createAppBar(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proyectos ',
                style: TextStyle(
                    fontSize: 25,
                    color: verdePrincipal,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                'movilizadores',
                style: TextStyle(
                    fontSize: 25,
                    color: verdeIconosBottom,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
              ),
            ],
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
          Container(
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
          SafeArea(
            child: SizedBox(
              height: size.height * 0.04,
            ),
          ),
          InfoSlide(),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          createCardNews(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          createCardNews(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.01,
            ),
          ),
          createCardNews(context),
          SafeArea(
            child: SizedBox(
              height: size.height * 0.06,
            ),
          ),
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

  _createDevelopmentPlan(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.20,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: amarilloTarjeta,
          ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    'Plan de Desarollo Cali unida por la vida 2020 - 2023',
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
          ),
          child: Image.asset('assets/meeting.png'),
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Card(
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
              SizedBox(
                height: size.height * 0.01,
              ),
              MaterialButton(
                textColor: blanco,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(7)),
                color: verdeBottom,
                onPressed: _launchURL,
                child: Text(
                  'Descargar',
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _loadInfoCard() async {
    // String url = Constants.url + 'featured-projects';
    // Response response = await Dio().get(url);
    try {
      Uri url = Uri.parse(Constants.url + 'featured-projects');
      var response = await http.get(url);

      List listJsonDecode = jsonDecode(response.body.toString());
      if (this.mounted) {
        setState(() {
          listCardProjects = listJsonDecode
              .map((mapProjects) => new FeaturedProjects.fromJson(mapProjects))
              .toList();
        });
      }
      return listCardProjects;
    } catch (Exeption) {
      _loadInfoCard();
    }
  }

  _createCardProjects(BuildContext context) {
    // dataProvider.loadDataLocal().then((dataProjects) {
    //   this.listCardProjects = dataProjects;
    // });
    final size = MediaQuery.of(context).size;
    _loadInfoCard();

    return Container(
      height: size.height * 0.30,
      child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          children: List.generate(listCardProjects.length, (index) {
            return Container(
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
                      listCardProjects[index].name,
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
                        listCardProjects[index].image,
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'InfoProyecto',
                              arguments: listCardProjects[index].id);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: verdePrincipal,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: blanco,
                          ),
                        ),
                      ))
                ],
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
          Navigator.pushNamed(context, 'FaqsPage');
        },
        child: Container(
          height: size.height * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
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
        Container(
            height: size.height * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    amarilloGallery,
                    naranjaGallery,
                  ]),
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

    String urlGo = planList[0].url;
    launch(urlGo);
  }
}
