import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/schedule.dart';

Widget crearCardSchedule(Schedule schedule, Size size) {
  return Container(
    width: size.width,
    height: 110,
    child: Center(
      child: Container(
        width: size.width * 0.9,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, 3))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                schedule.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 3),
                  Text(schedule.startDateFormat),
                  SizedBox(width: 10),
                  Icon(Icons.timelapse),
                  SizedBox(width: 3),
                  Text(schedule.starHourFormat),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
