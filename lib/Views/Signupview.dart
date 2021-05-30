import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final email = new TextEditingController();
  final password = new TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  DateTime _dateTime;
  String selecteddate;
  String gender = 'Male';
  int group = 1;
  bool validation(BuildContext context) {
    if (email.text.trim().isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Email is Required",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text.trim())) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Email is not Valid",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
    if (selecteddate == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Please Select Date of Birth",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }

    if (password.text.trim().isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Password is Required",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
    if (password.text.length < 8) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Password should be atleast 8 characters long",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
    return true;
  }

  signup() async {
    var data = {
      "email": email.text,
      "dob": selecteddate,
      "gender": gender,
      "type": "normal"
    };
    CoolAlert.show(
      barrierDismissible: false,
      context: context,
      type: CoolAlertType.loading,
      text: "Signing You Up!",
    );
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        FirebaseFirestore.instance.collection('user').add(data).then((v) async {
          Navigator.pop(context);
          print("Success");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
          // CoolAlert.show(
          //   barrierDismissible: false,
          //   context: context,
          //   type: CoolAlertType.error,
          //   text: "Email Already in Use",
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Adminhome(
          //       admin: false,
          //     ),
          //   ),
          // );
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.pop(context);
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "Email Already in Use",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/Images/dj.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Color(0xFF000000).withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                    right: 40,
                    left: 40,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'Assets/Images/logotransparent.png',
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Textfield(
                          password: false,
                          hinttext: "Email",
                          controller: email,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Textfield(
                          password: true,
                          hinttext: "Password",
                          controller: password,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("tapping");
                            showDatePicker(
                              // builder: (BuildContext context, Widget child) {
                              //   // return Theme(
                              //   //   data: ThemeData.light().copyWith(
                              //   //       primaryColor: Colors.bl,
                              //   //       accentColor: Constants.mainthemecolor,
                              //   //       colorScheme: ColorScheme.light(
                              //   //           primary: Constants.mainthemecolor)),
                              //   //   child: child,
                              //   // );
                              // },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime.now(),
                            ).then((date) {
                              setState(() {
                                _dateTime = date;
                                selecteddate = _dateTime.day.toString() +
                                    '/' +
                                    _dateTime.month.toString() +
                                    '/' +
                                    _dateTime.year.toString();
                                print(selecteddate);
                              });
                            });
                            //upload();
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: _dateTime == null
                                    ? Text("Date of Birth")
                                    : Text(selecteddate,
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Gender", //'Genre',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 30),
                              Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Radio(
                                      value: 1,
                                      groupValue: group,
                                      onChanged: (value) {
                                        setState(() {
                                          group = value;
                                          gender = 'Male';
                                          print(gender);
                                        });
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Radio(
                                      value: 2,
                                      groupValue: group,
                                      onChanged: (value) {
                                        setState(() {
                                          group = value;
                                          gender = 'Female';
                                          print(gender);
                                        });
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              if (!validation(context)) return;
                              signup();
                              //login();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  bool password;
  TextEditingController controller;
  String hinttext;
  Textfield({
    this.controller,
    this.password,
    this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            controller: controller,
            obscureText: password,
            //obscureText: true,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: hinttext,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
