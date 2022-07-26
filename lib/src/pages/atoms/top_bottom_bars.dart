import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/app_bar.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/custom_dialog.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../widgets/maps/maps_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

AppbarData? data;

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    _loadImgAppbar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: data != null
          ? Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data!.url!),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/hashtag.png',
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/logo1.png',
                      ),
                      Image.asset(
                        'assets/logo2.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
      backgroundColor: verdePrincipal,
    );
  }
}

_loadImgAppbar() async {
  try {
    Uri url = Uri.parse(Constants.url + 'appbar-screen');
    var response = await http.get(url);

    if (response != null) {
      var res = jsonDecode(response.body.toString());
      data = AppbarData.fromJson(res);
      print(data!.url);
    }
  } catch (e) {
    _loadImgAppbar();
  }
}

BottomAppBar createBottomAppBar(int numPantalla, BuildContext context) {
  List<Color> listaColores = [blanco, blanco, blanco, blanco, blanco];
  listaColores[numPantalla] = verdeIconosBottom;

  return BottomAppBar(
    color: Colors.transparent,
    child: Container(
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: verdePrincipal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          createButtom(
            'HomePage',
            SvgPicture.asset(
              'assets/home.svg',
              fit: BoxFit.contain,
              color: listaColores[0],
            ),
            'INICIO',
            context,
          ),
          createButtom(
            'ListadoProyectos',
            SvgPicture.asset(
              'assets/app.svg',
              fit: BoxFit.contain,
              color: listaColores[1],
            ),
            'PROYECTOS',
            context,
          ),
          createButtom(
            'CalendarioGeneral',
            SvgPicture.asset(
              'assets/calendar.svg',
              fit: BoxFit.contain,
              color: listaColores[2],
            ),
            'AGENDA',
            context,
          ),
          createButtom(
            'Mapas',
            SvgPicture.asset(
              'assets/location.svg',
              fit: BoxFit.contain,
              color: listaColores[3],
            ),
            'MAPA',
            context,
          ),
          createButtom(
            'FaqsPage',
            SvgPicture.asset(
              'assets/question.svg',
              fit: BoxFit.contain,
              color: listaColores[4],
            ),
            'PREGUNTAS',
            context,
          ),
        ],
      ),
    ),
  );
}

Container createButtom(
    String rutaDestino, SvgPicture icono, String texto, BuildContext context) {
  return Container(
    height: 70,
    child: Column(
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: IconButton(
            icon: icono,
            onPressed: () {
              if (rutaDestino == 'Mapas') {
                showCustomDialog(
                  context,
                  // title: "Mapa",
                  title: "Seleccione la opción que desea cargar",
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 6,
                        height: 30,
                        buttonColor: Color(0xff00C600),
                        child: MaterialButton(
                          color: Color(0xff00C600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Programas y Proyectos',
                            style: TextStyle(
                              color: Colors.grey[50],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MapsPage(
                                  isPrograms: true,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width / 6,
                          height: 30,
                          buttonColor: Theme.of(context).errorColor,
                          child: MaterialButton(
                            color: Color(0xff00C600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Sitios de interés',
                              style: TextStyle(
                                color: Colors.grey[50],
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MapsPage(
                                    isPrograms: false,
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                );
              } else {
                Navigator.popAndPushNamed(context, rutaDestino);
              }
            },
          ),
        ),
        Text(
          texto,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        )
      ],
    ),
  );
}
