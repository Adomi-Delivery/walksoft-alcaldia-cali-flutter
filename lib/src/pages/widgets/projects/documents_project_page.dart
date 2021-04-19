import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class DocumentsProjectPage extends StatefulWidget {
  @override
  _DocumentsProjectPageState createState() => _DocumentsProjectPageState();
}

class _DocumentsProjectPageState extends State<DocumentsProjectPage> {
  String nombreProyecto;

  @override
  Widget build(BuildContext context) {
    nombreProyecto = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: createAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Documentos',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: crearDocumentos(),
            ),
          )),
          Container(
            height: 100,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: verdePrincipal,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget crearDocumentos() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            child: Container(
              width: 360,
              height: 140,
              child: crearArchivo(
                  'Word', 'Acta de inicio', 'Actia de inicio proyecto'),
            ),
          ),
          Container(
            child: Container(
              width: 360,
              height: 140,
              child: crearArchivo('Pdf', 'Ingorme de progreso',
                  'Formatos oficiales para ingreso de notas'),
            ),
          ),
          Container(
            child: Container(
              width: 360,
              height: 140,
              child: crearArchivo('Excel', 'Plantillas de gestion',
                  'Formatos oficiales para ingresos de notas'),
            ),
          ),
        ],
      ),
    );
  }

  Widget crearArchivo(String tipo, String titulo, String texto) {
    String path = '';

    if (tipo == "Word") {
      path = "assets/word.png";
    } else if (tipo == "Pdf") {
      path = "assets/pdf.png";
    } else {
      path = "assets/excel.png";
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, 3))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(path),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              titulo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              texto,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 15,
                color: Colors.grey,
              ),
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Angela'),
                    Text('15-01-2021'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
