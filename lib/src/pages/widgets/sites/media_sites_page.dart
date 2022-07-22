import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sites.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class MediaSitesPage extends StatefulWidget {
  const MediaSitesPage({Key? key, required this.files}) : super(key: key);

  @override
  State<MediaSitesPage> createState() => _MediaSitesPageState();
  final List<Files> files;
}

class _MediaSitesPageState extends State<MediaSitesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            // height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Media',
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
              child: crearFotosMedio(),
            ),
          ),
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

  Widget crearFotosMedio() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        children: List.generate(
          widget.files.length,
          (index) {
            return crearFoto(widget.files[index].path!);
          },
        ),
      ),
    );
  }

  Widget crearFoto(String path) {
    return Expanded(
      child: Container(
        child: Center(
          child: Container(
            width: 160,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(path),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
