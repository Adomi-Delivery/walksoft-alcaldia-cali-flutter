import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController _controller;
  List<Project> listaProyectos = [];
  Set<Marker> _markers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: FutureBuilder(
          future: this.chargeProjects(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return generateGoogleMap();
            }
          }),
      bottomNavigationBar: createBottomAppBar(3, context),
    );
  }

  Future chargeProjects(BuildContext context) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects';
    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    print(data.request);
    final decodedData = json.decode(data.body);
    print(decodedData);
    for (var item in decodedData) {
      Project project = Project.fromJsonMap(item);

      listaProyectos.add(project);
    }

    print(listaProyectos.length);
    for (var item in listaProyectos) {
      _setMarkers(item);
    }
  }

  static final CameraPosition _initialPositionMap = CameraPosition(
    target: LatLng(3.440465, -76.511884),
    zoom: 12.5,
  );

  _onMapCreated(GoogleMapController controller) {
    this._controller = controller;
  }

  void _setMarkers(Project p) async {
    if (double.parse(p.latitude) != -1) {
      // final iconoMarker = await getMarkerPhotoRestaurant(r);
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(p.idProject),
            position: LatLng(
              double.parse(p.latitude),
              double.parse(p.longitude),
            ),
            // icon: iconoMarker,
            infoWindow: InfoWindow(
              title: p.name,
              snippet: p.location,
              onTap: () {
                Navigator.pushNamed(context, 'details', arguments: p.idProject);
              },
            ),
          ),
        );
      });
    }
  }

  Widget generateGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialPositionMap,
      onMapCreated: _onMapCreated,
      markers: _markers,
    );
  }
}
