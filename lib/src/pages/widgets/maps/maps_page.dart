import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/pages/helpers/widgets_to_marker.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key, this.isPrograms}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
  final bool? isPrograms;
}

class _MapsPageState extends State<MapsPage> {
  // ignore: unused_field
  GoogleMapController? _controller;
  List<Project>? listaProyectos;
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
        appBar: CustomAppBar(),
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: createBottomAppBar(3, context),
      );
    } else if (listaProyectos!.length == 0) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          // height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.insert_drive_file_outlined,
                size: 20,
                color: Colors.grey[400],
              ),
              Text(
                'Sin datos',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: createBottomAppBar(3, context),
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(),
        body: generateGoogleMap(),
        bottomNavigationBar: createBottomAppBar(3, context),
      );
    }
  }

  Future chargeProjects() async {
    String? uri;
    if (widget.isPrograms!) {
      uri = 'http://proyectosoft.walksoft.com.co/api/programs';
    } else {
      uri = 'http://proyectosoft.walksoft.com.co/api/projects';
    }

    String token = '';
    List<Project> temp = [];
    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    final decodedData = json.decode(data.body);

    for (var item in decodedData['data']) {
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
    if (double.parse(p.latitude!) != -1) {
      final iconoMarker = await getMarkerPhotoProject(p);
      setState(() {});
      _markers.add(
        Marker(
          markerId: MarkerId(p.id.toString()),
          position: LatLng(
            double.parse(p.latitude!),
            double.parse(p.longitude!),
          ),
          icon: iconoMarker,
          infoWindow: InfoWindow(
            title: p.name,
            snippet: p.location,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InfoProjectPage(
                    idProject: p.id!.toString(),
                  ),
                ),
              );
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
