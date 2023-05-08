import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/schedule.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/calendar_widget.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/schedule_widget.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeneralEventsSchedule extends StatefulWidget {
  @override
  _GeneralEventsScheduleState createState() => _GeneralEventsScheduleState();
}

class _GeneralEventsScheduleState extends State<GeneralEventsSchedule> {
  List<Schedule> _scheduleList = [];

  @override
  Widget build(BuildContext context) {
    _scheduleList = [];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: this.getScheduleProject(),
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
                    // height: 100,
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
                                'Agenda General de Eventos',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: 350,
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
      bottomNavigationBar: createBottomAppBar(2, context),
    );
  }

  Future getScheduleProject() async {
    String uri = 'http://proyectosoft.walksoft.com.co/api/schedule';
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
