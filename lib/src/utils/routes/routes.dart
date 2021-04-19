import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/home_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/login_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/slpash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => SplashPage(),
    'LoginPage': (context) => LoginPage(),
    'HomePage': (context) => HomePage(),
    // ...
  };
}
