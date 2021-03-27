import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final username = TextEditingController();
  final pswd = TextEditingController();
  final pswd2 = TextEditingController();
  final email = TextEditingController();
  bool signingUp = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amber,
        margin: EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  child: CupertinoTextField(
                    controller: username,
                    restorationId: 'username',
                    placeholder: 'username',
                    keyboardType: TextInputType.emailAddress,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: true,
                    autocorrect: false,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  child: CupertinoTextField(
                    controller: pswd,
                    restorationId: 'pswd',
                    placeholder: 'enter pswd',
                    keyboardType: TextInputType.emailAddress,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: true,
                    autocorrect: false,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 22),
                ),
                if (signingUp)
                  SizedBox(
                    height: 20,
                  ),
                if (signingUp)
                  Padding(
                    child: CupertinoTextField(
                      restorationId: 'pswd2',
                      controller: pswd2,
                      placeholder: 'enter pswd again',
                      keyboardType: TextInputType.emailAddress,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      obscureText: true,
                      autocorrect: false,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 22),
                  ),
                if (signingUp)
                  Padding(
                    child: CupertinoTextField(
                      controller: email,
                      restorationId: 'email',
                      placeholder: 'email',
                      keyboardType: TextInputType.emailAddress,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      obscureText: true,
                      autocorrect: false,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 22),
                  ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                    onPressed: () {
                      setState(() {
                        signingUp = !signingUp;
                      });
                    },
                    child: Text(
                      signingUp ? 'or log in' : 'or signup',
                      style: TextStyle(color: Colors.blue),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      Map<String, String> headers = {
                        "Content-type": "application/json"
                      };
                      Map mapjsonn = {
                        "email": "${email.text}",
                        "username": "${username.text}",
                        "password": "${pswd.text}"
                      };
                      // print(jsonn);
                      // var urL = Uri(
                      //     path: 'https://dtu-otg.herokuapp.com/auth/register/');

                      String url =
                          'https://dtu-otg.herokuapp.com/auth/register/';

                      if (signingUp) {
                        if (pswd.text == pswd2.text) {
                          http.Response response = await http.post(
                              Uri.https(
                                  'dtu-otg.herokuapp.com', 'auth/register/'),
                              headers: headers,
                              body: json.encode(mapjsonn));
                          int statusCode = response.statusCode;
                          print(
                              '///////${response.body}/////////////////////// $statusCode');

                          //404 not found
                          //201 obj created
                          //503 internal server error
                          //200 ok

                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    child: Text(response.body),
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: Text(signingUp ? 'sign up' : 'login'))
              ],
            )),
          ),
        ),
      ),
    );
  }
}
