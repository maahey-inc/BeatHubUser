import 'dart:io';
import 'dart:ui';

import 'package:beathubuser/Views/Forgotpassword.dart';
import 'package:beathubuser/Views/HomeView.dart';
import 'package:beathubuser/Views/Signupview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = new TextEditingController();
  final password = new TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance;
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

    return true;
  }

  loginuser(email, password) async {
    print('Logging in');
    CoolAlert.show(
      barrierDismissible: false,
      context: context,
      type: CoolAlertType.loading,
      text: "Loggin You In!",
    );
    try {
      final newuser = await _user.signInWithEmailAndPassword(
          email: email, password: password);
      if (newuser != null) {
        print("success");
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
        //Global.email = email;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Adminhome(
        //       admin: false,
        //     ),
        //   ),
        // );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('nouser');
        Navigator.pop(context);
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "User Not Found!",
        );
        //Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        print('wrongpassword');
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "Password Incorrect",
        );
        //Navigator.pop(context);
      }
    }
  }

  signInWithGoogle() async {
    try {
      print(' step 1--------------------------------------------');
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleAccount = await googleSignIn.signIn();

      print(
          '${googleAccount.authentication}--------------------------------------------');
      if (googleAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await googleAccount.authentication;
        print(' step 2--------------------------------------------');
        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          print(
              '${googleAuth.idToken}--------------------------------------------');
          final authResult = await FirebaseAuth.instance
              .signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          )
              .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          });
          print(
              '${authResult.user}-----------------------------------------user here');

          //return _userFromFirebase(authResult.user);
        } else {
          throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Authentication Token',
          );
        }
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign In aborted by user',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final facebookAccount =
        await facebookLogin.logIn(['public_profile', 'email']);

    if (facebookAccount != null &&
        facebookAccount.status == FacebookLoginStatus.loggedIn) {
      final authResult = await FirebaseAuth.instance
          .signInWithCredential(
        FacebookAuthProvider.credential(facebookAccount.accessToken.token),
      )
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      });
      //rint(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In aborted by user',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
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
                          // SizedBox(
                          //   height: 20,
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                if (!validation(context)) return;
                                loginuser(email.text, password.text);
                                //login();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      signInWithGoogle();
                                      //login();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Image.asset(
                                              "Assets/Images/googlelogo.png",
                                              height: 30,
                                            ),
                                          ),
                                          Text(
                                            'Sign In With Google',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     width: double.infinity,
                              //     alignment: Alignment.center,
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         signInWithFacebook();
                              //       },
                              //       child: Container(
                              //         alignment: Alignment.center,
                              //         width: MediaQuery.of(context).size.width *
                              //             0.22,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(25),
                              //           border: Border.all(color: Colors.white),
                              //         ),
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(15.0),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceAround,
                              //             children: [
                              //               Image.asset(
                              //                 "Assets/Images/facebooklogo.png",
                              //                 height: 40,
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PasswordView()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupView()));
                            },
                            child: Text(
                              "New Here? Signup",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
