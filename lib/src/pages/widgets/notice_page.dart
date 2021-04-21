import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      bottomNavigationBar: createBottomAppBar(4, context),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Text(
                    //   'Noticia',
                    //   style: TextStyle(
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Icon(
                    //     Icons.close,
                    //     size: 30,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: _createNotice(context),
            ),
          )),
        ],
      ),
    );
  }

  _createNotice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Llegaron las vacunas',
                  style: TextStyle(fontSize: 25),
                ),
                subtitle: Text('03 Marzo 2021, 02:30 PM'),
              ),
              Text(
                textoPrueva,
                textAlign: TextAlign.justify,
                // style: TextStyle(),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.asset(
                  'assets/rectangle.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
