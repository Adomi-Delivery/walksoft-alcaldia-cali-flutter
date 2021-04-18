import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/custom_cards_widgets.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/documents_media_widgets.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';

class InfoProjectPage extends StatefulWidget {
  @override
  _InfoProjectPageState createState() => _InfoProjectPageState();
}

class _InfoProjectPageState extends State<InfoProjectPage> {
  String _idProject;
  Project project;

  @override
  Widget build(BuildContext context) {
    _idProject = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    cargarProyecto(_idProject);

    return Scaffold(
      appBar: createAppBar(),
      body: FutureBuilder(
        future: this.cargarProyecto(_idProject),
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

  Future cargarProyecto(String id) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects/$id';

    final data = await http.get(Uri.parse(uri));
    final decodedData = json.decode(data.body);

    project = Project.fromJsonMap(decodedData);
  }

  Widget configFotoAtras() {
    return Hero(
      tag: project.idProject,
      child: FittedBox(
        child: Image.network(project.urlImage),
        fit: BoxFit.cover,
      ),
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
              project.name,
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
              Navigator.pushNamed(context, 'MediaProyecto');
            },
            child: Container(
              child: Center(
                child: Text(
                  'Media',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'DocumentosProyecto',
                  arguments: project.name);
            },
            child: Container(
              child: Center(
                child: Text(
                  'Documentos',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'CalendarioProyecto',
                  arguments: project);
            },
            child: Container(
              child: Center(
                child: Text(
                  'Agenda',
                ),
              ),
            ),
          ),
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
          crearTexto("¿Qué es?", project.description),
          SizedBox(height: 20),
          crearTexto("Ubicación", project.location),
          SizedBox(height: 20),
          crearTexto(
              "Costos", "\$" + project.costs + " es la inversión proyectada"),
          SizedBox(height: 20),
          crearTextoLista("Componentes", project.components),
          SizedBox(height: 20),
          crearLineaDeTiempo("Linea de tiempo"),
          SizedBox(height: 20),
          crearTextoYAlarma("Seguimos trabajando"),
          SizedBox(height: 20),
          crearFotoEstado("Foto de estado"),
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

  Widget crearLineaDeTiempo(String titulo) {
    List<Widget> listaDocumentos1 = [
      createDocumentWidget(Icon(Icons.attach_file_rounded)),
      createDocumentWidget(Icon(Icons.mail_outline))
    ];
    List<Widget> listaMedia1 = [
      createMediaWidget("Youtube"),
      createMediaWidget("Persona"),
    ];
    List<Widget> listaMedia2 = [
      createMediaWidget("Youtube"),
      createMediaWidget("Persona"),
      createMediaWidget("Persona"),
      createMediaWidget("Persona")
    ];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: double.infinity),
          Text(
            titulo,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TimelineTile(
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Colors.red,
              padding: EdgeInsets.all(8),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.red,
              thickness: 6,
            ),
            alignment: TimelineAlign.manual,
            lineXY: 0.3,
            endChild: Container(
              constraints: const BoxConstraints(
                minHeight: 300,
              ),
              child: customCardTimeLine(
                'Inicio del proyecto',
                project.startDate,
                'Aqui van los detalles',
                listaDocumentos1,
                listaMedia1,
                '15 May 2020 - 30 June 2020 (45 Days)',
                'Webmaster',
              ),
            ),
            startChild: Container(
              constraints: const BoxConstraints(
                minHeight: 120,
              ),
              child: Center(
                child: Text(project.startDate),
              ),
            ),
          ),
          TimelineTile(
            beforeLineStyle: const LineStyle(
              color: Colors.blue,
              thickness: 6,
            ),
            alignment: TimelineAlign.manual,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Colors.blue,
              padding: EdgeInsets.all(8),
            ),
            lineXY: 0.3,
            endChild: Container(
              constraints: const BoxConstraints(
                minHeight: 300,
              ),
              child: customCardTimeLine(
                'Grandes adelantos',
                project.endDate,
                'Aqui van los detalles',
                listaDocumentos1,
                listaMedia2,
                "",
                'Webmaster',
              ),
            ),
            startChild: Container(
              constraints: const BoxConstraints(
                minHeight: 120,
              ),
              child: Center(
                child: Text(project.endDate),
              ),
            ),
          ),
        ],
      ),
    );
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
            width: 160,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: verdeProyectoSuave,
            ),
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
        ],
      ),
    );
  }

  Widget crearFotoEstado(String titulo) {
    if (project.status) {
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

  Widget crearTexto(String titulo, String infoProyecto) {
    String textoPoner = infoProyecto;

    if (infoProyecto == 'null') {
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
            children: <Widget>[SizedBox(width: 20), Text(textoPoner)],
          ),
        ],
      ),
    );
  }
}
