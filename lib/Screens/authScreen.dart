import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/authForm.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final username = TextEditingController();
  final pswd = TextEditingController();
  final pswd2 = TextEditingController();
  final email = TextEditingController();
  final otp = TextEditingController();
  bool signingUp = false;
  bool waiting = false;
  bool signUpOtpStep = false;
  bool obscureText = true;
  bool forgotPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: //AuthForm(),
            SingleChildScrollView(
                child: Form(
          key: formGlobalKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //.......................HEADING
              Container(
                child: Text(
                  signingUp ? 'Sign Up' : 'Log in',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                margin: EdgeInsets.only(top: 60, bottom: 20),
              ),
              //......................TEXT ENTRYING

              if (signingUp)
                if (!signUpOtpStep)
                  Padding(
                    child: CupertinoTextFormFieldRow(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      controller: email,
                      //   restorationId: 'email',
                      placeholder: 'email',
                      keyboardType: TextInputType.emailAddress,
                      // clearButtonMode: OverlayVisibilityMode.editing,
                      obscureText: false,
                      autocorrect: false,
                      validator: (value) {
                        if (signingUp) {
                          if (value.isNotEmpty && !value.contains('@')) {
                            return '@ nhi daala...hmm';
                          }
                          if (value.isEmpty) {
                            return 'enter email';
                          }
                        }
                      },
                    ),
                    padding: EdgeInsets.only(
                        left: 22, top: 0, bottom: 20, right: 22),
                  ),
              if (!signUpOtpStep)
                Padding(
                  child: CupertinoTextFormFieldRow(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    maxLength: 20,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    controller: username,
                    //  restorationId: 'username',
                    placeholder: 'username',
                    keyboardType: TextInputType.emailAddress,
                    //   clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value.length > 20) {
                        return 'string too long';
                      }
                      if (value.isEmpty) {
                        return 'enter username';
                      }
                    },
                  ),
                  padding:
                      EdgeInsets.only(left: 22, top: 0, bottom: 20, right: 22),
                ),
              if (!forgotPassword)
                if (!signUpOtpStep)
                  Padding(
                    child: CupertinoTextFormFieldRow(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      controller: pswd,
                      //   restorationId: 'pswd',
                      placeholder: 'enter pswd',
                      keyboardType: TextInputType.emailAddress,
                      // clearButtonMode: OverlayVisibilityMode.editing,
                      obscureText: obscureText,
                      autocorrect: false,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'atleast 6 digit';
                        }
                        if (value.isEmpty) {
                          return 'enter pswd';
                        }
                      },
                    ),
                    padding: EdgeInsets.only(
                        left: 22, top: 0, bottom: 20, right: 22),
                  ),
              if (signingUp)
                if (!signUpOtpStep)
                  Padding(
                    child: CupertinoTextFormFieldRow(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      controller: pswd2,
                      // restorationId: 're enter pswd',
                      placeholder: 're enter enter pswd',
                      keyboardType: TextInputType.visiblePassword,
                      //  clearButtonMode: OverlayVisibilityMode.editing,
                      obscureText: obscureText,
                      autocorrect: false,
                      validator: (value) {
                        if (signingUp) {
                          if (value.length < 6) {
                            return 'atleast 6 digit';
                          }
                          if (value.isEmpty) {
                            return 're enter pswd';
                          }
                        }
                      },
                    ),
                    padding: EdgeInsets.only(
                        left: 22, top: 0, bottom: 20, right: 22),
                  ),
              if (signUpOtpStep)
                Padding(
                  child: CupertinoTextFormFieldRow(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    controller: otp,
                    //  restorationId: 'otp',
                    placeholder: 'enter OTP',
                    keyboardType: TextInputType.number,
                    //  clearButtonMode: OverlayVisibilityMode.editing,
                    obscureText: false,
                    autocorrect: false,
                    validator: (value) {
                      if (signingUp && signUpOtpStep) {
                        if (value.contains(' ')) {
                          return 'no spaces allowed';
                        }
                        if (value.contains('.')) {
                          return '. not allowed';
                        }
                        if (value.length != 6) {
                          return '6 digits bro';
                        }
                        if (value.isEmpty) {
                          return 'enter otp';
                        }
                      }
                    },
                  ),
                  padding:
                      EdgeInsets.only(left: 22, top: 0, bottom: 20, right: 22),
                ),
              if (!signUpOtpStep)
                Padding(
                  padding:
                      EdgeInsets.only(left: 22, top: 0, bottom: 0, right: 22),
                  child: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Text(
                        obscureText ? 'show pswd' : 'hide pswd',
                        style: TextStyle(color: Colors.amber),
                      )),
                ),
              if (!signUpOtpStep)
                Padding(
                  padding:
                      EdgeInsets.only(left: 22, top: 0, bottom: 0, right: 22),
                  child: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          signingUp = !signingUp;
                        });
                      },
                      child: Text(
                        signingUp ? 'or log in' : 'or signup',
                        style: TextStyle(color: Colors.amber),
                      )),
                ),
              Padding(
                padding:
                    EdgeInsets.only(left: 22, top: 0, bottom: 20, right: 22),
                child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.amber),
                      enableFeedback: true,
                      // elevation: MaterialStateProperty.all(0),XXXXXXXXXXXXXXXXXXXXXXXXXXX
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () async {
                      if (formGlobalKey.currentState.validate() && !waiting) {
                        if (!signingUp && !signUpOtpStep) {
                          setState(() {
                            waiting = true;
                          });
                          Map<String, String> headerslogin = {
                            "Content-type": "application/json"
                          };
                          Map mapjsonnlogin = {
                            "username": "${username.text}",
                            "password": "${pswd.text}"
                          };
                          http.Response response = await http.post(
                              Uri.https('dtu-otg.herokuapp.com', 'auth/login/'),
                              headers: headerslogin,
                              body: json.encode(mapjsonnlogin));
                          int statusCode = response.statusCode;
                          print(
                              '///////${response.body}/////////////////////// $statusCode');

                          Map resp = json.decode(response.body);
                          if (resp["status"] == 'FAILED')
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      child: Text(response.body),
                                    ),
                                  );
                                });
                          setState(() {
                            waiting = false;
                            if (resp["status"] != 'FAILED')
                              Navigator.of(context).pushNamed('/TabsScreen');
                          });
                        }
//////////////////////////////////////////////////////////////
                        if (signUpOtpStep) {
                          setState(() {
                            waiting = true;
                          });
                          String urlEmailVerify =
                              'https://dtu-otg.herokuapp.com/auth/email-verify/';
                          Map<String, String> headersEmailVerify = {
                            "Content-type": "application/json"
                          };
                          Map mapjsonnEmailVerify = {
                            "username": "${username.text}",
                            "code": int.parse(otp.text)
                          };
                          http.Response response = await http.post(
                              Uri.https('dtu-otg.herokuapp.com',
                                  'auth/email-verify/'),
                              headers: headersEmailVerify,
                              body: json.encode(mapjsonnEmailVerify));
                          int statusCode = response.statusCode;
                          print(
                              '///////${response.body}/////////////////////// $statusCode');

                          Map resp = json.decode(response.body);
                          if (resp["status"] != 'OK')
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      child: Text(response.body),
                                    ),
                                  );
                                });
                          setState(() {
                            waiting = false;
                            if (resp["status"] == 'OK')
                              Navigator.of(context)
                                  .pushNamed('/EnterDetailsScreen');
                          });
                        }
////////////////////////////////////////////////////////////////////////////////////
                        if (signingUp && !signUpOtpStep) {
                          if (pswd.text == pswd2.text) {
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
                            setState(() {
                              waiting = true;
                            });
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
                            Map resp = json.decode(response.body);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      child: Text(response.body),
                                    ),
                                  );
                                });
                            setState(() {
                              waiting = false;
                              if (resp["status"] == 'OK') signUpOtpStep = true;
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      child: Text('both pswds should be same'),
                                    ),
                                  );
                                });
                          }
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  child: Text('enter valid inputs'),
                                ),
                              );
                            });
                      }
                    },
                    child: waiting
                        ? CircularProgressIndicator()
                        : Text(signingUp
                            ? signUpOtpStep
                                ? '       verify otp        '
                                : '            send otp            '
                            : '              log in              ')),
              )
            ],
          ),
        )));
  }
}
