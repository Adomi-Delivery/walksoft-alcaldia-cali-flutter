import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/custom_project_card.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class ListProjectPage extends StatefulWidget {
  @override
  _ListProjectPageState createState() => _ListProjectPageState();
}

class _ListProjectPageState extends State<ListProjectPage> {
  List<Project> listaProyectos = [];

  @override
  Widget build(BuildContext context) {
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
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: azulBoton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Secretaría',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(width: 50),
                                Icon(
                                  Icons.arrow_downward_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
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
      bottomNavigationBar: createBottomAppBar(1),
    );
  }

  Future chargeProjects(BuildContext context) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects?offices=1';

    final data = await http.get(Uri.parse(uri));
    final decodedData = json.decode(data.body);

    for (var item in decodedData) {
      Project project = Project.fromJsonMap(item);

      listaProyectos.add(project);
    }
  }
}
