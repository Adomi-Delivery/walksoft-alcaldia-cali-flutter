import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walksoft Cali',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
      //TODO: Cambiar cuando este el .dart del home page
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(builder: (context) => HomePage())
      // },
    );
  }
}
