import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/Models/splash.dart';
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
    // _loadInfo();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, 'LoginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    // _loadInfo();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: fondo,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          // height: size.height * 1,
          child: Image.asset(
            'assets/splash.png',
            height: size.height * 0.9,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _loadInfo() async {
    // var client = http.Client();
    final back = '\\';

    Uri url = Uri.parse(Constants.url + 'starting-screen');
    var response = await http.get(url);
    final tmp = response.body.toString().replaceAll(back, "");
    List listJsonDecode =
        jsonDecode(response.body.toString().replaceAll(back, ""));
    infoSplash = listJsonDecode
        .map((mapProjects) => new Splash.fromJson(mapProjects))
        .toList();
    print(infoSplash[0].url);
    // return response;
  }
}
