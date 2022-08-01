import 'package:flutter/material.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/notice.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/atoms/top_bottom_bars.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/utils/constants/constants.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key, this.notice}) : super(key: key);
  final Notice? notice;
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: createBottomAppBar(4, context),
      body: Container(
        child: _createNotice(context, widget.notice!),
      ),
    );
  }

  _createNotice(BuildContext context, Notice notice) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              notice.title!,
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(notice.date!),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            notice.content!,
            textAlign: TextAlign.justify,
            // style: TextStyle(),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(notice.coverImage!),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
