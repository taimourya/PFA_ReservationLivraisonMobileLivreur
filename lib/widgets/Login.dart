import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login/theme.dart';
import 'package:livreur/API/Host.dart';
import 'package:livreur/widgets/Home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {


  Duration get loginTime => Duration(milliseconds: 500);


  Future<void> setSharedUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  @override
  void initState() {
    super.initState();
    getSharedUserId();
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    if(id != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      userType: LoginUserType.name,
      userValidator: (val) {
        if(val!.length < 4)
          return "vous devez saisir plus que 4 caractere";
      },
      messages: LoginMessages(userHint: "Username"),
      theme: LoginTheme(primaryColor: Colors.green),
      title: 'Restaurant',
      logo: 'assets/images/logo.png',
      onLogin: (data) {

        return Future.delayed(loginTime).then((_) {
          return http.post(
            Uri.parse('http://${Host.url}:8080/user/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String> {
              "username": data.name,
              "password": data.password,
              "source": "livreur"
            }),
          ).then((response) {
            print(response.body);
            print(response.statusCode);
            dynamic data = json.decode(response.body);
            if(response.statusCode == 200) {
              print("user id : ${data['user_id']}");
              setSharedUserId(data['user_id']);
              return null;
            }
            else {
              return "error : ${data['message']}";
            }
          }).catchError((err) {
            print(err);
          });
        });
      },
      onSignup: (data) {
        return Future.delayed(loginTime).then((_) {

          return null;
        });
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      onRecoverPassword: (data) {
        return Future.delayed(loginTime).then((_) {

          return null;
        });
      },
    );
  }
}