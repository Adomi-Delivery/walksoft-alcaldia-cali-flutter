import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/Models/splash.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/Contstants.dart';

class SplashPage extends StatefulWidget {
  static List<Splash> infoSplash = [];
  static String imgUrl;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String rutaImgCambio;

  bool visible = true;
  @override
  void initState() {
    super.initState();
    // _loadInfo();
    //   // Timer(Duration(seconds: 3), () {});
  }

  @override
  Widget build(BuildContext context) {
    // _loadInfo();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Center(
              child: Image.network(
                  'https://files.slack.com/files-tmb/T01D52RSH2N-F01UN7YT03V-146ce3175e/image_720.png',
                  height: size.height * 0.40),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadInfo() async {
    var client = http.Client();
    const headers = {
      // 'Content-Type': 'application/json',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive'
    };

    //  String url = Constants.url +
    //         "starting-screen" ;

    //     uriResponse = await Dio().get(url);

    //     List listJsonDecode = jsonDecode(uriResponse.toString());
    //     SplashPage.infoSplash = listJsonDecode
    //         .map((mapUser) => new Splash.fromJson(mapUser))
    //         .toList();

    var uriResponse = await client
        .get(Uri.parse(Constants.url + 'starting-screen'), headers: headers);
    print(uriResponse.body);

    Map<String, dynamic> map = jsonDecode(uriResponse.body);
    List listJsonDecodeInfo = map[''];
    print(uriResponse.statusCode);

    SplashPage.infoSplash = listJsonDecodeInfo
        .map((mapInfo) => new Splash.fromJson(mapInfo))
        .toList();
    SplashPage.imgUrl = SplashPage.infoSplash[0].url;
    print(SplashPage.infoSplash[0].url);
  }
}
