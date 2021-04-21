import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/splash.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class SplashPage extends StatefulWidget {
  static String imgUrl;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static List<Splash> infoSplash = [];

  @override
  void initState() {
    super.initState();
    _loadInfo();
    Timer(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, 'HomePage');
    });
  }

  @override
  Widget build(BuildContext context) {
    // _loadInfo();

    return Scaffold(
      // backgroundColor: fondo,
      body: Center(child: _createSplash()),
    );
  }

  _loadInfo() async {
    final back = '\\';

    Uri url = Uri.parse(Constants.url + 'starting-screen');
    var response = await http.get(url);
    Timer(Duration(seconds: 3), () {});
    final tmp = response.body.toString().replaceAll(back, "");
    String jsonComplete = "[" + tmp;
    jsonComplete = jsonComplete + "]";
    final decodedData = json.decode(jsonComplete);

    Splash info = Splash.fromJson(decodedData[0]);
    infoSplash.add(info);

    setState(() {
      _createSplash();
    });
  }

  _createSplash() {
    final size = MediaQuery.of(context).size;

    if (infoSplash.length > 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: size.height * 0.9,
        child: Image.network(
          // 'assets/splash.png',

          infoSplash[0].url,
          // height: size.height * 0.9,
          fit: BoxFit.cover,
        ),
      );
    } else {
      setState(() {});
    }
  }
}
