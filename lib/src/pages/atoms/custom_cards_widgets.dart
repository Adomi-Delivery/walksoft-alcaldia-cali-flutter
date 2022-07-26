import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/file.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/notice.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sites.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/timeline.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/helpers/currency.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/notice/notice_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/sites/sites_info_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

Widget customCardTimeLine(TimeLine t, int index) {
  String titulo = t.title;
  String date = t.createdAt;
  String detalles = t.details;
  String notas = t.note;
  String autor = t.user;
  List<File>? listFiles = t.files;

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
            Row(
              children: generarListaDocumentos(t.files!),
            ),
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

List<Widget> generarListaDocumentos(List<File> lista) {
  List<Widget> l = [SizedBox(width: 5)];
  String path = "";

  for (var item in lista) {
    if (item.ext == "jpg") {
      path = "assets/camera.png";
    } else if (item.ext == "docx") {
      path = "assets/word.png";
    } else if (item.ext == "xlsx") {
      path = "assets/excel.png";
    }

    l.add(GestureDetector(
      onTap: () {
        _launchURL(item.url!);
      },
      child: Container(
        height: 40,
        width: 40,
        child: Center(
          child: Image.asset(path),
        ),
      ),
    ));
    l.add(SizedBox(width: 10));
  }

  return l;
}

_launchURL(String url) async {
  await canLaunch(url) ? await launch(url) : throw 'No se puede abrir: $url';
}

Widget createCustomCardProject(
    BuildContext context, int index, Size size, Project project) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.5,
                blurRadius: 5,
                offset: Offset(3, 3))
          ],
        ),
        child: configInformation(context, project, size),
      ),
    ),
  );
}

Widget createCustomCardSites(
    BuildContext context, int index, Size size, Sites project) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.5,
                blurRadius: 5,
                offset: Offset(3, 3))
          ],
        ),
        child: configInformationSites(context, project, size),
      ),
    ),
  );
}

Widget createCustomCardNotice(
    BuildContext context, int index, Size size, Notice project) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.5,
                blurRadius: 5,
                offset: Offset(3, 3))
          ],
        ),
        child: configInformationNotice(context, project, size),
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
      SizedBox(width: 20),
      Container(
        width: size.width * 0.20,
        child: botonFinal(context, project),
      ),
    ],
  );
}

Widget configInformationSites(BuildContext context, Sites sites, Size size) {
  return Row(
    children: <Widget>[
      SizedBox(width: 10),
      Container(
        child: fotoProyectoSites(sites),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * 0.50,
        child: informacionCentralSites(sites),
      ),
      // SizedBox(width: 10),
      Container(
        width: size.width * 0.15,
        child: botonFinalSites(context, sites),
      ),
    ],
  );
}

Widget configInformationNotice(BuildContext context, Notice sites, Size size) {
  return Row(
    children: <Widget>[
      SizedBox(width: 10),
      Container(
        child: fotoProyectoNotice(sites),
      ),
      SizedBox(width: 10),
      Container(
        width: size.width * 0.50,
        child: informacionCentralNotice(sites),
      ),
      // SizedBox(width: 10),
      Container(
        width: size.width * 0.15,
        child: botonFinalNotice(context, sites),
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
      tag: project.id!,
      child: FittedBox(child: Image.network('${project.coverImage}')),
    ),
  );
}

Widget fotoProyectoSites(Sites project) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      image: DecorationImage(
        image: NetworkImage(project.files![0].path!),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    ),
    // child: Hero(
    //   tag: project.id!,
    //   child: FittedBox(child: Image.network('${project.files![0].path}')),
    // ),
  );
}

Widget fotoProyectoNotice(Notice project) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      image: DecorationImage(
        image: NetworkImage(project.coverImage!),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    ),
    // child: Hero(
    //   tag: project.id!,
    //   child: FittedBox(child: Image.network('${project.files![0].path}')),
    // ),
  );
}

Widget informacionCentral(Project project) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        project.name!,
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
          Text(project.startDate!),
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
          Text('${formatCurrency(number: double.parse(project.costs!))}'),
        ],
      ),
    ],
  );
}

Widget informacionCentralSites(Sites project) {
  final dateTime = DateTime.parse(project.createdAt!);

  final format = DateFormat('yyyy-MM-dd');
  final _startAt = format.format(dateTime);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        project.name!,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 5),
      SizedBox(
        // width: 100,
        child: Text(
          project.description!,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // SizedBox(height: 5),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Tipo: ',
      //       maxLines: 1,
      //       softWrap: true,
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //     Text(project.category!),
      //   ],
      // ),
    ],
  );
}

Widget informacionCentralNotice(Notice project) {
  final dateTime = DateTime.parse(project.createdAt!);

  final format = DateFormat('yyyy-MM-dd');
  final _startAt = format.format(dateTime);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        project.title!,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 5),
      SizedBox(
        // width: 100,
        child: Text(
          project.content!,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // SizedBox(height: 5),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       'Tipo: ',
      //       maxLines: 1,
      //       softWrap: true,
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //     Text(project.category!),
      //   ],
      // ),
    ],
  );
}

Widget botonFinal(BuildContext context, Project project) {
  return Align(
    alignment: Alignment.bottomRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfoProjectPage(
              idProject: project.id!.toString(),
            ),
          ),
        );
        // Navigator.pushNamed(context, 'InfoProyecto', arguments: project.id!);
      },
      child: Container(
        width: 50,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: azulBoton,
        ),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Center(
          child: Text(
            'Ver',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

Widget botonFinalSites(BuildContext context, Sites project) {
  return Align(
    alignment: Alignment.bottomRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfoSitestPage(
              idSites: project.id!.toString(),
            ),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: azulBoton,
        ),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Center(
          child: Text(
            'Ver',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

Widget botonFinalNotice(BuildContext context, Notice project) {
  return Align(
    alignment: Alignment.bottomRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NoticePage(
              notice: project,
            ),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: azulBoton,
        ),
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Center(
          child: Text(
            'Ver',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
