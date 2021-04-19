import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/schedule.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/calendar_widget.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/schedule_widget.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleProjectPage extends StatefulWidget {
  @override
  _ScheduleProjectPageState createState() => _ScheduleProjectPageState();
}

class _ScheduleProjectPageState extends State<ScheduleProjectPage> {
  Project _project;

  List<Schedule> _scheduleList = [];

  @override
  Widget build(BuildContext context) {
    _scheduleList = [];
    _project = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: createAppBar(),
      body: FutureBuilder(
        future: this.getScheduleProject(_project.idProject),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width * 0.9,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                _project.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
                    width: size.width * 0.9,
                    child: createCalendar(),
                  ),
                  SizedBox(height: 10, width: size.width),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _scheduleList.length,
                    itemBuilder: (context, index) {
                      return crearCardSchedule(_scheduleList[index], size);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future getScheduleProject(String id) async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/schedule?project=$id';
    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});
    final decodedData = json.decode(data.body);

    for (var item in decodedData) {
      Schedule s = Schedule.fromJsonToMap(item);
      _scheduleList.add(s);
    }
  }
}
