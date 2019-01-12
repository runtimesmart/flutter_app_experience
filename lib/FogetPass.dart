import 'package:flutter/material.dart';
import 'package:flutter_app1/LabelTextRow.dart';

class FogetPass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text("找回密码"),
        ),
      body: Column(
        children: <Widget>[
          LabelTextRow(
              labelTxt:"手机号",
              hintTxt: "请输入手机号",
          ),
        ],
      ),
    );
  }


}