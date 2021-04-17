import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

Widget createCustomCardProject(
    BuildContext context, int index, Size size, Project project) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: size.height * 0.12,
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
        child: configInformation(context, project, size),
      ),
    ),
  );
}

Widget configInformation(BuildContext context, Project project, Size size) {
  return Row(
    children: <Widget>[
      SizedBox(width: 10),
      Container(
        width: size.width * 0.13,
        height: size.height * 0.1,
        child: fotoProyecto(project),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * 0.53,
        child: informacionCentral(project),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * 0.15,
        child: botonFinal(context, project),
      ),
    ],
  );
}

Widget fotoProyecto(Project project) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Hero(
      tag: project.idProject,
      child: FittedBox(child: Image.network('${project.urlImage}')),
    ),
  );
}

Widget informacionCentral(Project project) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        project.name,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inicio: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(project.startDate),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Costo: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(project.costs),
        ],
      ),
    ],
  );
}

Widget botonFinal(BuildContext context, Project project) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pushNamed(context, 'InfoProyecto');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: azulBoton,
          ),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Text(
            'Ver',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
