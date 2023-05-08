import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/notice.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/sites.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../atoms/custom_cards_widgets.dart';

class NoticeListPage extends StatefulWidget {
  NoticeListPage({Key? key}) : super(key: key);

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  List<Color>? colors;
  Color? colorBtn1;
  Color? colorBtn2;
  List<Notice> listNotices = [];
  List<String>? catergories = [];
  List<String>? auxCategories = [];
  bool? isSelected;

  List<Category>? categoryList;
  List<Notice>? auxlistNotices;

  @override
  void initState() {
    isSelected = false;
    colors = [verdeBottom, Colors.grey[400]!];
    colorBtn1 = colors![0];
    colorBtn2 = colors![1];
    categoryList = [];
    auxlistNotices = [];
    listNotices.clear();
    chargeNotices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    auxlistNotices!.clear();
    listNotices.clear();
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: chargeNotices(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (listNotices.isEmpty) {
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
                  itemCount: listNotices.length,
                  itemBuilder: (context, index) {
                    return createCustomCardNotice(
                        context, index, size, listNotices[index]);
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
            for (var i = 0; i < listNotices.length; i++) {
              if (listNotices[i].type == categoryList![index].title) {
                auxlistNotices!.add(listNotices[i]);
                listNotices = [...auxlistNotices!.toSet()];
              }
            }

            setState(() {
              // listNotices = [];
              // listNotices.clear();
              categoryList![index].isSelected = true;
              listNotices = [...auxlistNotices!.toSet()];
              // listNotices.addAll(auxlistNotices!);
            });
            // chargeNotices();
          },
        );
      },
    );
  }

  Future chargeNotices() async {
    // if (!isSelected!) {
    String? uri;

    uri = 'http://proyectosoft.walksoft.com.co/api/news';

    String token = '';

    final data =
        await http.get(Uri.parse(uri), headers: {'Authorization': token});

    final decodedData = json.decode(data.body);

    for (var item in decodedData['data']) {
      Notice project = Notice.fromJson(item);

      listNotices.add(project);
    }

    listNotices.forEach((item) {
      catergories!.add(item.type!);
    });

    // } else {
    // listNotices.clear();
    // listNotices = auxlistNotices!.toList();
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
