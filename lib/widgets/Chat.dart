import 'dart:async';
import 'dart:convert';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:livreur/widgets/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatState();
  }
  
}
class ChatState extends State<Chat>{

  dynamic data;
  dynamic dataProfile;
  List<ChatMessage> chatMessages = [];

  Timer? timer;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getProfil();
      _getConversationEnCours();
      timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _getMessages());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print("id . $id");
    setState(() {
      userId = id == null? 0 : id;
    });
  }

  void _getConversationEnCours() {
    var url = Uri.parse(
        "${Host.url}/conversation/check?user_id=$userId"
    );

    http.get(url).then((response) {
      print(response.body);
      setState(() {
        if(response.statusCode == 200) {
          data = json.decode(response.body);
        }
        else {

        }
      });
    }).catchError((err) {
      print(err);
    });
  }

  void _getProfil() {
    var url = Uri.parse("${Host.url}/user?id=$userId");
    http.get(url).then((response) {
      print(response.body);
      setState(() {
        dataProfile = json.decode(response.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  void _getMessages() {
    if(data == null) return;
    var url = Uri.parse(
        "${Host.url}/conversation/messages?conversation_id=${data['id']}"
    );
    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        dynamic dataRep = json.decode(response.body);
        setState(() {
          this.chatMessages.clear();
        });
        for(int i = 0; i < dataRep.length; i++) {
          setState(() {
            addMessage(
                dataRep[i]['content'].toString(),
                dataRep[i]['sender']['firstname'].toString(),
                dataRep[i]['sender']['lastname'].toString(),
                dataRep[i]['sender']['user_id'].toString(),
                DateTime.parse(dataRep[i]['date'])
            );
          });
        }
      }

    }).catchError((err) {
      print(err);
    });
  }

  void _sendMesage(String message) {
    http.post(
      Uri.parse('${Host.url}/conversation/message/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "user_id": this.userId,
        "message": message,
        "conversation_id": data['id']
      }),
    );
  }

  void addMessage(String message,String firstname, String lastname, String uid, DateTime date) {
    chatMessages.add(
        ChatMessage(
          text: "$message",
          user: ChatUser(
            name: "$firstname $lastname",
            uid: "$uid",
            //avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
          ),
          createdAt: date,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          data != null?
          "${data['assistant']['firstname']} ${data['assistant']['lastname']}"
          :
          ''
        ),
      ),
      drawer: DrawerMenu(),
      body:  DashChat(
        user: ChatUser(
          name: dataProfile == null? ""
              : "${dataProfile['firstname']} ${dataProfile['lastname']}",
          uid: "$userId",
          avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        messages: chatMessages,
        onSend: (chatMessage ) {
          print(chatMessage.text.toString());
          _sendMesage(chatMessage.text.toString());
          setState(() {
            //chatMessages.add(chatMessage);
          });
        },
      ),
    );
  }

  
}