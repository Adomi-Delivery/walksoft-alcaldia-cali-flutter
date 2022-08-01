import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/buttons_home.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/developmentPlan.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/featured_projects.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sliders.dart';

import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/slider.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/slider_home.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/gallery/gallery_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/notice/notice_list_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeaturedProjects> listCardProjects = [];
  List<ButtonsHome> listButtons = [];
  List<Sliders> listSliders = [];
  List<DevelopmentPlan> planList = [];
  @override
  void initState() {
    _loadInfoCard();
    _loadInfoSliders();
    _loadButtons();
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
                fontSize: 23,
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
              height: size.height * 0.001,
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
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: 23,
                        color: blanco,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: blanco,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: verdePrincipal,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
              height: size.height * 0.03,
            ),
          ),
          listButtons.isNotEmpty ? _createButtons(context) : SizedBox(),
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
      }

      return listCardProjects;
    } catch (e) {
      _loadInfoCard();
    }
  }

  _loadButtons() async {
    try {
      Uri url = Uri.parse(Constants.url + 'app-button-images');
      var response = await http.get(url);

      if (this.mounted) {
        print('_loadButtons');
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["data"];
        setState(() {
          listButtons = data
              .map((mapProjects) => new ButtonsHome.fromJson(mapProjects))
              .toList();
        });
      }

      return listButtons;
    } catch (e) {
      _loadButtons();
    }
  }

  _createCardProjects(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.46,
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

  _createButtons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoticeListPage(),
            ),
          ),
          child: Container(
            height: size.height * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Colors.grey[300]!,
                  offset: Offset(1, 2),
                  blurRadius: 4.0,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(listButtons[0].route!),
                fit: BoxFit.cover,
                // alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'sites'),
          child: Container(
            height: size.height * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Colors.grey[300]!,
                  offset: Offset(1, 2),
                  blurRadius: 4.0,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(listButtons[1].route!),
                fit: BoxFit.cover,
                // alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GalleryPage(),
              ),
            );
          },
          child: Container(
            height: size.height * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Colors.grey[300]!,
                  offset: Offset(1, 2),
                  blurRadius: 4.0,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(listButtons[2].route!),
                fit: BoxFit.cover,
                // alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
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
