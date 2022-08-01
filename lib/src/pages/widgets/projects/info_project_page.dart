import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/timeline.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/custom_cards_widgets.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/helpers/currency.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';

class InfoProjectPage extends StatefulWidget {
  const InfoProjectPage({Key? key, this.idProject}) : super(key: key);

  @override
  _InfoProjectPageState createState() => _InfoProjectPageState();
  final String? idProject;
}

class _InfoProjectPageState extends State<InfoProjectPage> {
  Project? project;
  late Size size;

  @override
  void initState() {
    cargarProyecto(widget.idProject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.idProject = ModalRoute.of(context)!.settings.arguments as String?;
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: this.cargarProyecto(widget.idProject),
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

  Future cargarProyecto(String? id) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects/$id';
    String token = '';

    final response =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["data"];
    // final decodedData = json.decode(data.body);

    project = Project.fromJsonMap(map['data']);

    return project;
  }

  Widget configFotoAtras() {
    return FittedBox(
      child: Image.network(project!.coverImage!),
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
              project!.name!,
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
                project!.type != 'PROGRAM' ? 'El proyecto' : 'El Programa',
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
                  arguments: project!.name);
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
          crearTexto("¿Qué es?", project!.description),
          SizedBox(height: 20),
          project!.location == null
              ? crearTexto("Ubicación", project!.location)
              : SizedBox(),
          SizedBox(height: 20),
          project!.costs == null
              ? crearTexto(
                  "Costos",
                  formatCurrency(number: double.parse(project!.costs!)) +
                      " es la inversión proyectada")
              : SizedBox(),
          SizedBox(height: 20),
          // crearTextoLista("Componentes", project!.components!),
          SizedBox(height: 20),
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

  Widget crearLineaDeTiempo(String titulo) {
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
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(
              height: 0,
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: project!.timeline!.length,
            itemBuilder: (context, index) {
              return createTimeLineDynamic(
                  titulo, project!.timeline![index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget createTimeLineDynamic(String titulo, TimeLine tl, int index) {
    return Container(
      child: TimelineTile(
        beforeLineStyle: const LineStyle(
          color: Colors.red,
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
          constraints: const BoxConstraints(),
          child: customCardTimeLine(tl, index),
        ),
        startChild: Container(
          constraints: const BoxConstraints(),
          child: Center(
            child: Text(project!.endDate!),
          ),
        ),
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
    if (project!.status! == 1) {
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
