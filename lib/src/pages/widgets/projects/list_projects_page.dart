import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/offices.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/custom_cards_widgets.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class ListProjectPage extends StatefulWidget {
  @override
  _ListProjectPageState createState() => _ListProjectPageState();
}

class _ListProjectPageState extends State<ListProjectPage> {
  List<Project> listaProyectos = [];

  Offices o = Offices.createBasic(id: '0', name: 'Todas');

  List<Offices> listaOffices = [];

  String? _optSeleccionada;

  @override
  Widget build(BuildContext context) {
    listaOffices.clear();
    listaOffices.add(o);
    Size size = MediaQuery.of(context).size;
    listaProyectos.clear();
    return Scaffold(
      appBar: createAppBar(),
      body: FutureBuilder(
        future: this.chargeProjects(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Proyectos',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: azulBoton,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.all(10),
                              child: _crearDropdown()),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listaProyectos.length,
                    itemBuilder: (context, index) {
                      print(listaProyectos.length);
                      return createCustomCardProject(
                          context, index, size, listaProyectos[index]);
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: createBottomAppBar(1, context),
    );
  }

  Future chargeProjects(BuildContext context) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects?offices=1';
    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});

    final decodedData = json.decode(data.body);

    for (var item in decodedData) {
      Project project = Project.fromJsonMap(item);

      listaProyectos.add(project);
    }

    String uriOffices = 'http://proyectosoft.walksoft.com.co/api/offices';

    final data2 = await http
        .get(Uri.parse(uriOffices), headers: {'Authorization': token});

    final decodedData2 = json.decode(data2.body);

    for (var item in decodedData2) {
      Offices ofi = Offices.fromJsonMap(item);

      listaOffices.add(ofi);
    }
  }

  Widget _crearDropdown() {
    return Container(
      width: 180,
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            'Filtrar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: _optSeleccionada,
          items: getOpcionesDropDown(),
          style: TextStyle(
            color: Colors.white,
          ),
          dropdownColor: azulBoton,
          isExpanded: true,
          onChanged: (dynamic opcionSeleccionada) {
            setState(
              () {
                _optSeleccionada = opcionSeleccionada;
              },
            );
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];

    listaOffices.forEach((off) {
      lista.add(DropdownMenuItem(
        child: Container(
          child: Text(
            off.name!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        value: off.id,
      ));
    });

    return lista;
  }
}
