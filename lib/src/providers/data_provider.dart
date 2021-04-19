import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:walksoft_alcaldia_cali_flutter/src/Models/featured_projects.dart';

class _DataProvider {
  List<FeaturedProjects> dataProjects = [];
  _DataProvider() {
    // loadDataLocal();
  }
  Future<List<FeaturedProjects>> loadDataLocal() async {
    final resp = await rootBundle.loadString('data/featured_projects.json');
    List dataMap = json.decode(resp);
    dataProjects = dataMap
        .map((mapProjects) => new FeaturedProjects.fromJson(mapProjects))
        .toList();
    print(resp);
    return dataProjects;
  }
}

final dataProvider = new _DataProvider();
