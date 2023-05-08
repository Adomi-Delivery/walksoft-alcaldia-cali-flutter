import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/offices.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sites.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../atoms/custom_cards_widgets.dart';

class PlacesOfInterest extends StatefulWidget {
  PlacesOfInterest({Key? key}) : super(key: key);

  @override
  State<PlacesOfInterest> createState() => _PlacesOfInterestState();
}

class _PlacesOfInterestState extends State<PlacesOfInterest> {
  List<Color>? colors;
  Color? colorBtn1;
  Color? colorBtn2;
  List<Sites> listaProyectos = [];
  List<String>? catergories = [];
  List<String>? auxCategories = [];
  bool? isSelected;

  List<Category>? categoryList;
  List<Sites>? auxlistaProyectos;

  @override
  void initState() {
    isSelected = false;
    colors = [verdeBottom, Colors.grey[400]!];
    colorBtn1 = colors![0];
    colorBtn2 = colors![1];
    categoryList = [];
    auxlistaProyectos = [];
    listaProyectos.clear();
    chargeProjects();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    auxlistaProyectos!.clear();
    listaProyectos.clear();
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: chargeProjects(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (listaProyectos.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: _createCategories()),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listaProyectos.length,
                  itemBuilder: (context, index) {
                    return createCustomCardSites(
                        context, index, size, listaProyectos[index]);
                  },
                ),
              ],
            );
          }
        },
      ),
      // bottomNavigationBar: createBottomAppBar(1, context),
    );
  }

  _createCategories() {
    if (!isSelected!) {
      auxCategories = [...catergories!.toSet()];
      debugPrint(auxCategories.toString());
      auxCategories!.forEach(
        (e) {
          categoryList!.add(Category(e, false));
        },
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList!.length,
      itemBuilder: (context, index) {
        return categoryCard(
          context,
          category: categoryList![index],
          onPressed: (b) {
            categoryList!.forEach((category) {
              category.isSelected = false;
              isSelected = false;
            });
            for (var i = 0; i < listaProyectos.length; i++) {
              if (listaProyectos[i].category == categoryList![index].title) {
                auxlistaProyectos!.add(listaProyectos[i]);
                listaProyectos = [...auxlistaProyectos!.toSet()];
              }
            }

            setState(() {
              // listaProyectos = [];
              // listaProyectos.clear();
              categoryList![index].isSelected = true;
              listaProyectos = [...auxlistaProyectos!.toSet()];
              // listaProyectos.addAll(auxlistaProyectos!);
            });
            // chargeProjects();
          },
        );
      },
    );
  }

  Future chargeProjects() async {
    // if (!isSelected!) {
    String? uri;

    uri = 'http://proyectosoft.walksoft.com.co/api/sites';

    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});

    final decodedData = json.decode(data.body);

    for (var item in decodedData['data']) {
      Sites project = Sites.fromJson(item);

      listaProyectos.add(project);
    }

    listaProyectos.forEach((item) {
      catergories!.add(item.category!);
    });

    // } else {
    // listaProyectos.clear();
    // listaProyectos = auxlistaProyectos!.toList();
    // log('la puerca esta en el matadero');
    // }
  }

  Widget categoryCard(BuildContext context,
      {Category? category, Function(bool)? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 3.5,
        // height: 40,
        buttonColor: category!.isSelected ? verdeBottom : Colors.white,
        child: MaterialButton(
            child: Text(category.title,
                style: TextStyle(
                    color: category.isSelected ? Colors.white : Colors.grey)),
            onPressed: () => onPressed!(true),
            color: category.isSelected ? verdeBottom : Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class Category {
  final String title;
  bool isSelected;
  Category(this.title, this.isSelected);
}
