import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ExpandText extends StatefulWidget {
  ExpandText({this.labelHeader, this.dec, this.shortDec});

  String labelHeader;
  String dec;
  String shortDec;

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.widget.labelHeader,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Html(
            data: descTextShowFlag ? this.widget.dec : this.widget.shortDec,
            style: {
              "div": Style(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                fontSize: FontSize.medium,
              ),
            },
          ),
          Align(
            child: GestureDetector(
              child: Text(
                descTextShowFlag ? "show less" : "Show More",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: (){
                setState(() {
                  descTextShowFlag =!descTextShowFlag;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
