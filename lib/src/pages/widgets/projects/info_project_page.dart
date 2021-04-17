import 'package:flutter/material.dart';

class InfoProjectPage extends StatefulWidget {
  @override
  _InfoProjectPageState createState() => _InfoProjectPageState();
}

class _InfoProjectPageState extends State<InfoProjectPage> {
  String _idProject;

  @override
  Widget build(BuildContext context) {
    _idProject = ModalRoute.of(context).settings.arguments;

    cargarProyecto(_idProject);

    return Container(
      child: Text('Hola'),
    );
  }

  Future cargarProyecto(String id) async {}
}
