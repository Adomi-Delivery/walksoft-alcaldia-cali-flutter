import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/faqs.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:http/http.dart' as http;
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class FaqsPage extends StatefulWidget {
  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  List<Faqs> listFaqs = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // listFaqs.clear();
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: this.chargeFaqs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Preguntas Frecuentes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        'Encunetra una respuesta rápida y efectiva',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listFaqs.length,
                      itemBuilder: (context, index) {
                        print(listFaqs.length);
                        return createCustomCardFaqs(index);
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: createBottomAppBar(4, context),
    );
  }

  Future chargeFaqs() async {
    Uri url = Uri.parse(Constants.url + 'faqs');
    var response = await http.get(url, headers: headers);

    String token = '';

    final data = await http.get(url, headers: {'Authorization': token});
    print(data.request);
    final decodedData = json.decode(data.body);

    for (var item in decodedData) {
      Faqs project = Faqs.fromJson(item);

      listFaqs.add(project);
    }
    return listFaqs;
  }

  createCustomCardFaqs(index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: size.height * 0.10,
        decoration: BoxDecoration(
          color: blanco,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              listFaqs[index].question!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                listFaqs[index].answer!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
