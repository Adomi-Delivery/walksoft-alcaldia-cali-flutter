import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

Widget createDocumentWidget(Icon icono) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: grizSuave,
    ),
    child: icono,
  );
}

Widget createMediaWidget(String tipoMedia) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: grizSuave,
    ),
    child: generarIcono(tipoMedia),
  );
}

generarIcono(String tipoMedia) {
  if (tipoMedia == "Youtube") {
    return FittedBox(
      child: Image.asset("assets/youtubelogo.png"),
    );
  } else {
    return FittedBox(
      child: Image.asset("assets/personalogo.png"),
    );
  }
}
