import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: Container(
        child: Center(
          child: Text("Try"),
        ),
      ),
      bottomNavigationBar: createBottomAppBar(0),
    );
  }
}
