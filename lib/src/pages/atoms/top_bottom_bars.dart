import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar createAppBar() {
  return AppBar(
    title: Row(
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
        SizedBox(width: 20),
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

BottomAppBar createBottomAppBar(int numPantalla) {
  List<Color> listaColores = [blanco, blanco, blanco, blanco, blanco];
  listaColores[numPantalla] = verdeIconosBottom;

  return BottomAppBar(
    child: Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: verdePrincipal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          createButtom(
              'InicioPage',
              SvgPicture.asset(
                'assets/home.svg',
                fit: BoxFit.contain,
                color: listaColores[0],
              ),
              'INICIO'),
          createButtom(
              'InicioPage',
              SvgPicture.asset(
                'assets/app.svg',
                fit: BoxFit.contain,
                color: listaColores[1],
              ),
              'PROYECTOS'),
          createButtom(
              'InicioPage',
              SvgPicture.asset(
                'assets/calendar.svg',
                fit: BoxFit.contain,
                color: listaColores[2],
              ),
              'AGENDA'),
          createButtom(
              'InicioPage',
              SvgPicture.asset(
                'assets/location.svg',
                fit: BoxFit.contain,
                color: listaColores[3],
              ),
              'MAPA'),
          createButtom(
              'InicioPage',
              SvgPicture.asset(
                'assets/question.svg',
                fit: BoxFit.contain,
                color: listaColores[4],
              ),
              'PREGUNTAS'),
        ],
      ),
    ),
  );
}

Container createButtom(String rutaDestino, SvgPicture icono, String texto) {
  return Container(
    height: 70,
    child: Column(
      children: [
        IconButton(
            icon: icono,
            onPressed: () {
              //TODO: Agregar ruta cuando se hace
              // Navigator.pushReplacementNamed(context, routeName)
            }),
        Text(
          texto,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
