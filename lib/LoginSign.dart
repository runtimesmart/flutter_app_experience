import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app1/FogetPass.dart';

import 'LabelTextRow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'url_entity.dart';
import 'MessageUtils.dart';
class LoginSignState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginSign();
  }

}

class LoginSign extends State<LoginSignState> {

  LabelTextRow labelTextRow;
  BuildContext context;
  SharedPreferences sharedPreferences;
  final List<Tab> myTabs = <Tab>[
    new Tab(text: '登录'),
    new Tab(text: '注册')
  ];

//  @override
//  StatelessElement createElement() {
//    // TODO: implement createElement
//
//    return super.createElement();
//  }
  TextEditingController accountController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nickController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController registPassController = new TextEditingController();
  FocusNode accountFocus = new FocusNode(),
      passFocus = new FocusNode();
  bool isRememCheck = true;
  bool isfogetCheck = false;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return new DefaultTabController(
      length: myTabs.length,
      child: new Scaffold(
        appBar: new AppBar(
            bottom: new TabBar(
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              tabs: myTabs,
              indicatorWeight: 5,
              isScrollable: true,
            )
        ),
        body: new TabBarView(
          children: myTabs.map((Tab tab) {
            if (tab.text == "登录") {
              return new Column(
                children: <Widget>[
                  LabelTextRow(
                    labelTxt: "账号:",
                    hintTxt: "请输入用户名",
                    controller: accountController,
                    focusNode: accountFocus,
                  ),
                  LabelTextRow(
                    labelTxt: "密码:",
                    hintTxt: "请输入密码",
                    isPassword: true,
                    focusNode: passFocus,
                    controller: passController,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(70, 20, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: isRememCheck, onChanged: (isChange) {
                          setState(() {
                            isRememCheck = isChange;
                          });
                        }
                        ),
                        Text("记住密码"),
                        GestureDetector(
                            child: Padding(
                                padding: EdgeInsets.only(left:50),
                                child: Text("忘记密码?",
                                  style: TextStyle(color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                            ),
                            onTap: () {
                              fogetPass();
                            }
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RaisedButton(
                          onPressed: loginPress,
                          child: Text(
                            "登陆",
                            style: TextStyle(color: Colors.white,),
                          ),
                          elevation: 14,
                          splashColor: Theme
                              .of(context)
                              .buttonColor,
                          highlightElevation: 20,
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),


                  ),
                ],
              );
            } else {
              return new Column(
                children: <Widget>[
                  LabelTextRow(
                      labelTxt: "昵称:",
                      hintTxt: "请输入昵称"
                  ),
                  LabelTextRow(
                      labelTxt: "手机:",
                      hintTxt: "请输入手机号"
                  ),
                  LabelTextRow(
                    labelTxt: "密码:",
                    hintTxt: "请输入密码",
                    isPassword: true,

                  ),
                ],
              );
            }
          }).toList(),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    checkAndSet();

  }
  void loginPress() {
    if (accountController.text.trim() == "") {
      Fluttertoast.showToast(msg: "用户名不为空");
//      Toast.toast(context, "用户名不为空");
      FocusScope.of(context).requestFocus(accountFocus);
      return;
    }
    rememberPsss(isRememCheck);
    loginToServer();

  }
  void loginToServer() async {
  var dio = new Dio ();
  FormData formData=new FormData.from({"mobile":"2323323"});
  String url="http://192.168.0.37:8200/api/v1/gate";
  print("开始请求");

  //请求
  dio.post(url).then((response){
    Map<String,dynamic> map= json.decode(json.encode(response.data));
    print("输出数据"+URLEntity.fromJson(map).httpApiHost);
    Fluttertoast.showToast(msg:URLEntity.fromJson(map).httpApiHost);
  });
  dio.interceptor.response.onError=(DioError err){
    print("登录错误信息"+err.toString());
  };

  String replaceStr = 'Android Studio';
//  print('你知道' +
//      '${replaceStr.toUpperCase()}'
//      + '最新版本是多少吗？' ==
//      '你知道ANDROID STUDIO最新版本是多少吗？');
//  assert('你知道' +
//      '${replaceStr.toUpperCase()}'
//      + '最新版本是多少吗？' ==
//      '你知道ANDROID STUDIO最新版本k是多少吗？');


  WsUtils.getInstance()
    .sendMessage("{\"header\":{\"type\":\"setting/volum\",\"imei\":\"888\",\"uid\":0},\"payload\":{\"media\":0, \"tel\":90}}");
    
//  WsUtils.sendMessage("sdfsdf");

  }

  void rememberPsss(bool isRemember) async {
    if(null==sharedPreferences) {
      sharedPreferences = await SharedPreferences.getInstance();
    }

    if (isRemember) {
      sharedPreferences.setString("userName", accountController.text);
      sharedPreferences.setString("userPass", passController.text);
    } else {
      sharedPreferences.remove("userName");
      sharedPreferences.remove("userPass");
    }
  }

  void checkAndSet() async {
    if(null==sharedPreferences) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    if(sharedPreferences.getString("userName")!=null
    && sharedPreferences.getString("userName")!=""){
      accountController.value=new TextEditingValue(text:sharedPreferences.getString("userName"));
      passController.value=new TextEditingValue(text:sharedPreferences.getString("userPass"));
    }
    Fluttertoast.showToast(msg: "开始ws连接");
    WsUtils.getInstance().connetc();

  }

  void fogetPass() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FogetPass()));
  }


}