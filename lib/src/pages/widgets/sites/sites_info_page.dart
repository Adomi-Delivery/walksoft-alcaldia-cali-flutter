import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sites.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/sites/media_sites_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class InfoSitestPage extends StatefulWidget {
  const InfoSitestPage({Key? key, this.idSites}) : super(key: key);

  @override
  _InfoSitestPageState createState() => _InfoSitestPageState();
  final String? idSites;
}

class _InfoSitestPageState extends State<InfoSitestPage> {
  Sites? sites;
  late Size size;

  @override
  void initState() {
    cargarProyecto(widget.idSites);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.idSites = ModalRoute.of(context)!.settings.arguments as String?;
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: this.cargarProyecto(widget.idSites),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  //Configuracion parte trasera
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: configFotoAtras(),
                      ),
                      Container(
                        color: grizSuave,
                        width: double.infinity,
                        child: configInformacionProyecto(),
                      )
                    ],
                  ),
                  //Nombre en container amarillo superior
                  configBarraSuperior(size),
                  //Container en la mitad con opciones "elproyecto, media, documentos, agenda"
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.35),
                      configBarraMedio(size),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: createBottomAppBar(1, context),
    );
  }

  Future cargarProyecto(String? id) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/sites/$id';
    String token = '';

    final response =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["data"];
    // final decodedData = json.decode(data.body);

    sites = Sites.fromJson(map['data']);

    return sites;
  }

  Widget configFotoAtras() {
    return FittedBox(
      child: Image.network(sites!.files![0].path!),
      fit: BoxFit.cover,
    );
  }

  Widget configBarraSuperior(Size size) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: amarillo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 30),
          Container(
            width: size.width * 0.8,
            child: Text(
              sites!.name!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget configBarraMedio(Size size) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(3, 3))
        ],
      ),
      height: size.height * 0.08,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.04,
            width: size.width * 0.25,
            decoration: BoxDecoration(
              color: verdeProyectoSuave,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Center(
              child: Text(
                'El proyecto',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MediaSitesPage(files: sites!.files!),
                ),
              );
            },
            child: Container(
              child: Center(
                child: Text(
                  'Media',
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'DocumentosProyecto',
          //         arguments: sites!.name);
          //   },
          //   child: Container(
          //     child: Center(
          //       child: Text(
          //         'Documentos',
          //       ),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'CalendarioProyecto',
          //         arguments: sites);
          //   },
          //   child: Container(
          //     child: Center(
          //       child: Text(
          //         'Agenda',
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget configInformacionProyecto() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 25),
          crearTexto("¿Qué es?", sites!.description),
          SizedBox(height: 20),
          crearTexto("Ubicación", sites!.address),
          SizedBox(height: 20),
          // crearTexto(
          //     "Costos", "\$" + sites!.! + " es la inversión proyectada"),
          // SizedBox(height: 20),
          // crearTextoLista("Componentes", sites!.components!),
          // SizedBox(height: 20),
          // crearLineaDeTiempo("Linea de tiempo"),
          // SizedBox(height: 20),
          // crearTextoYAlarma("Seguimos trabajando"),
          // SizedBox(height: 20),
          // crearFotoEstado("Foto de estado"),
        ],
      ),
    );
  }

  Widget crearTextoLista(String titulo, List<String> info) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: double.infinity),
          Text(
            titulo,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getListaInfo(info),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getListaInfo(List<String> info) {
    List<Widget> lista = [];

    for (var item in info) {
      lista.add(Container(
        width: 300,
        child: Text(
          '- ' + item,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ));
      lista.add(SizedBox(height: 5));
    }

    return lista;
  }

  Widget crearTextoYAlarma(String titulo) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: verdeProyectoSuave,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sms_rounded,
                    color: blanco,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Encuesta',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget crearFotoEstado(String titulo) {
    if (sites!.status! == 1) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: double.infinity),
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/estadoProyecto.png'),
                      fit: BoxFit.fill)),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget crearTexto(String titulo, String? infoProyecto) {
    String? textoPoner = infoProyecto;

    if (infoProyecto == null) {
      textoPoner = 'Hace falta!!';
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: double.infinity),
          Text(
            titulo,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                width: size.width * 0.8,
                child: Text(
                  textoPoner!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
