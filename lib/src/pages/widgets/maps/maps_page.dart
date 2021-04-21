import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/pages/helpers/widgets_to_marker.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // ignore: unused_field
  GoogleMapController _controller;
  List<Project> listaProyectos;
  Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();

    chargeProjects().then((value) {
      setState(() {
        this.listaProyectos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listaProyectos == null) {
      chargeProjects();
      return Scaffold(
        appBar: createAppBar(),
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: createBottomAppBar(3, context),
      );
    } else {
      return Scaffold(
        appBar: createAppBar(),
        body: generateGoogleMap(),
        bottomNavigationBar: createBottomAppBar(3, context),
      );
    }
  }

  Future chargeProjects() async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/projects';
    String token = '';
    List<Project> temp = [];
    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    print(data.request);
    final decodedData = json.decode(data.body);
    for (var item in decodedData) {
      Project project = Project.fromJsonMap(item);

      temp.add(project);
    }

    for (var item in temp) {
      _setMarkers(item);
    }

    return temp;
  }

  _onMapCreated(GoogleMapController controller) {
    this._controller = controller;
  }

  static final CameraPosition _initialPositionMap = CameraPosition(
    target: LatLng(3.440465, -76.511884),
    zoom: 12.5,
  );

  void _setMarkers(Project p) async {
    if (double.parse(p.latitude) != -1) {
      final iconoMarker = await getMarkerPhotoProject(p);
      setState(() {});
      _markers.add(
        Marker(
          markerId: MarkerId(p.idProject),
          position: LatLng(
            double.parse(p.latitude),
            double.parse(p.longitude),
          ),
          icon: iconoMarker,
          infoWindow: InfoWindow(
            title: p.name,
            snippet: p.location,
            onTap: () {
              Navigator.pushNamed(context, 'InfoProyecto',
                  arguments: p.idProject);
            },
          ),
        ),
      );
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
