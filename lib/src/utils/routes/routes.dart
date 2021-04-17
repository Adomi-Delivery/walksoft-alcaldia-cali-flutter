import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/slpash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => SplashPage(),
    // 'LogInPage' => LoginPage(),
    // 'HomePage' => HomePage(),
    // ...
  };
}
