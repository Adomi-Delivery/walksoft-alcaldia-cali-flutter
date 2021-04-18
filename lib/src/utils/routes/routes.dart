import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/eventsSchedule/general_events_schedule.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/info_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/list_projects_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/media_project_page.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/projects/schedule_project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/widgets/slpash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => ListProjectPage(),
    'ListadoProyectos': (context) => ListProjectPage(),
    'InfoProyecto': (context) => InfoProjectPage(),
    'CalendarioProyecto': (context) => ScheduleProjectPage(),
    'CalendarioGeneral': (context) => GeneralEventsSchedule(),
    'MediaProyecto': (context) => MediaProjectPage(),
  };
}
