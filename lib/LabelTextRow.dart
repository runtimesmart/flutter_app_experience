import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


 class LabelTextRow extends StatelessWidget {
   String labelTxt="";
   TextEditingController controller;
   FocusNode focusNode;
   String  hintTxt="";
   bool isPassword;
    LabelTextRow({
     Key key,
      @required this.hintTxt,
      @required this.labelTxt,
      this.isPassword=false,
      this.controller,
      this.focusNode,
    });

//    Widget buildLabelRow(){
//      return
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20,10,5,10),
              child: Text(
                labelTxt,
                style: TextStyle(fontSize: 20),
              )
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.text,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintTxt, // ignore: implicit_this_reference_in_initializer
                  contentPadding: EdgeInsets.all(9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}