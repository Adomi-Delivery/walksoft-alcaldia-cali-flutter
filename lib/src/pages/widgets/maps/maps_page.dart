import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: generateGoogleMap(),
      bottomNavigationBar: createBottomAppBar(3, context),
    );
  }

  Widget generateGoogleMap() {
    return Container();
  }
}
