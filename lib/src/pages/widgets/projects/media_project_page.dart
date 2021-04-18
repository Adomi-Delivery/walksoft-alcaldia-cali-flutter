import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class MediaProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
            child: Center(
              child: crearFotosMedio(),
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

  Widget crearFotosMedio() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  crearFoto('assets/imagen1.png'),
                  crearFoto('assets/imagen3.png'),
                  crearFoto('assets/imagen5.png'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  crearFoto('assets/imagen2.png'),
                  crearFoto('assets/imagen4.png'),
                  crearFoto('assets/imagen6.png'),
                ],
              ),
            ),
          ),
        ),
      ],
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
                Radius.circular(30),
              ),
              image: DecorationImage(
                image: ExactAssetImage(path),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
