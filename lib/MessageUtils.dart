
import 'dart:async';
import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageUtils {
  static WebSocket _webSocket;
  static num _id = 0;
  static Map<String, dynamic> header = {
  };

  static void connect() {
    Future<WebSocket> futureWebSocket =WebSocket.connect('ws://echo.websocket.org', headers: header);
    futureWebSocket.then((WebSocket ws) {
      _webSocket = ws;
      _webSocket.readyState;

      _webSocket.addStream()
      // 监听事件

      void onData(dynamic content) {
        _id++;
        SendMessage("收到" + content);
        print("新消息" + content + _id.toString());
      }


      _webSocket.listen(onData,
          onError: (a) {
            print("error");
          },
          onDone: () => print("done"));
    });
  }

  static void closeSocket() {
    _webSocket.close();
  }

  // 向服务器发送消息
  static void SendMessage(String message) {
    _webSocket.add(message);
  }
}

//class WsUtils {
//   WebSocketChannel channel;
//   num _id = 0;
//   Map<String, dynamic> header = {};
//
//  static WsUtils _instance;
//  static WsUtils getInstance(){
//    if(null==_instance){
//      _instance=new WsUtils();
//    }
//    return _instance;
//  }
//   WsUtils connetc() {
//    channel = new IOWebSocketChannel.connect('ws://192.168.0.161:9000/2-1-1-1-1,888',
//        headers: header,pingInterval: new Duration(seconds:3));
//
//    channel.stream.listen(onReceive, onError: (a) {
//      print("error 需要重连"+a.toString());
//    }, onDone: () {
//      print("done");
//    });
//    return _instance;
//  }
//
//  void onReceive(dynamic content) {
//    _id++;
//    sendMessage("收到" + content);
//    print("新消息" + content + _id.toString());
//  }
//   void closeSocket() {
//    channel.sink.close();
//  }
//
//
//  // 向服务器发送消息
//   void sendMessage(String message) {
//    channel.sink.add(message);
//
//
//  }
//}
