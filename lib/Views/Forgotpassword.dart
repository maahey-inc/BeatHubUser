import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class PasswordView extends StatefulWidget {
  @override
  _PasswordViewState createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final email = new TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            CoolAlert.show(
                              barrierDismissible: false,
                              context: context,
                              type: CoolAlertType.loading,
                              text: "Sending Password Reset Email!",
                            );
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text)
                                .then((value) {
                              Navigator.pop(context);
                              CoolAlert.show(
                                  barrierDismissible: false,
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "An Email has been sent to you!",
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                            });
                            //signup();
                            //login();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Send Reset Password Mail',
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
