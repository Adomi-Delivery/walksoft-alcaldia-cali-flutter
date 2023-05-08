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

  List<bool>? isSelected;
  List<Color>? colors;
  Color? colorBtn1;
  Color? colorBtn2;
  bool? _isPrograms;

  @override
  void initState() {
    isSelected = [true, false];
    colors = [verdeBottom, Colors.grey[400]!];
    colorBtn1 = colors![0];
    colorBtn2 = colors![1];
    _isPrograms = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listaOffices.clear();
    listaOffices.add(o);
    Size size = MediaQuery.of(context).size;
    listaProyectos.clear();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2.5,
                height: 35,
                buttonColor: colorBtn1,
                child: MaterialButton(
                  color: colorBtn1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Proyectos',
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < isSelected!.length; i++) {
                        isSelected![i] = i == 0;
                        colorBtn1 = colors![0];
                        colorBtn2 = colors![1];
                        _isPrograms = false;
                      }
                    });
                  },
                ),
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2.5,
                height: 35,
                buttonColor: colorBtn2,
                child: MaterialButton(
                  color: colorBtn2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Programas',
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < isSelected!.length; i++) {
                        isSelected![i] = i == 1;
                        colorBtn2 = colors![0];
                        colorBtn1 = colors![1];
                        _isPrograms = true;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: this.chargeProjects(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (listaProyectos.isEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.insert_drive_file_outlined,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                      Text(
                        'Sin datos',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        width: double.infinity,
                        // height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                _isPrograms! ? 'Programas' : 'Proyectos',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: azulBoton,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: _crearDropdown()),
                          ],
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
        ],
      ),
      bottomNavigationBar: createBottomAppBar(1, context),
    );
  }

  Future chargeProjects(BuildContext context) async {
    String? uri;
    if (_isPrograms!) {
      uri = 'http://proyectosoft.walksoft.com.co/api/programs';
    } else {
      uri = 'http://proyectosoft.walksoft.com.co/api/projects';
    }

    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});

    final decodedData = json.decode(data.body);

    for (var item in decodedData['data']) {
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
      width: 130,
      height: 30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Filtrar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          value: _optSeleccionada,
          items: getOpcionesDropDown(),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white,
          ),
          dropdownColor: blanco,
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
