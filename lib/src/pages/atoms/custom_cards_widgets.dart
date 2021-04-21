import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/timeline.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

Widget customCardTimeLine(TimeLine t) {
  String titulo = t.title;
  String date = t.createdAt;
  String detalles = t.details;
  String notas = t.note;
  String autor = t.user;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: blanco,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(3, 3))
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Text(
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 7),
            Text(date),
            SizedBox(height: 7),
            Text('Detalles:'),
            Text(detalles),
            SizedBox(height: 15),
            Text('Documentos:'),
            //TODO: REVISAR
            // Row(
            //   children: [
            //     documentos[0],
            //     documentos[1],
            //   ],
            // ),
            SizedBox(height: 20),
            Text('Media: '),
            // Row(
            //   children: <Widget>[
            //     media[0],
            //     media[0],
            //   ],
            // ),
            SizedBox(height: 20),
            Text('Notas:'),
            Text(notas),
            SizedBox(height: 15),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(autor),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

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
        width: size.width * 0.40,
        child: informacionCentral(project),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * 0.20,
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
          Navigator.pushNamed(context, 'InfoProyecto',
              arguments: project.idProject);
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
