import 'dart:io';
import 'dart:ui';

import 'package:beathubuser/Views/Allartists.dart';
import 'package:beathubuser/Views/Allsongsview.dart';
import 'package:beathubuser/Views/Romanticsongsview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'Allsongsview.dart';
import 'Allsongsview.dart';
import 'Hiphopsongsview.dart';
import 'Loginview.dart';
import 'Popsongview.dart';
import 'RapSongs.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List widgetlist = [
    HomePage(),
    AllSongsView(),
    Text(""),
  ];
  int _selectedItemPosition = 0;
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(0);

  //int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.blueGrey;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: SnakeNavigationBar.color(
              //shadowColor: Colors.transparent,
              // height: 80,
              behaviour: snakeBarStyle,
              snakeShape: snakeShape,
              shape: bottomBarShape,
              //padding: padding,

              ///configuration for SnakeNavigationBar.color
              snakeViewColor: selectedColor,
              selectedItemColor:
                  snakeShape == SnakeShape.indicator ? selectedColor : null,
              unselectedItemColor: Colors.blueGrey,

              showUnselectedLabels: showUnselectedLabels,
              showSelectedLabels: showSelectedLabels,

              currentIndex: _selectedItemPosition,
              onTap: (index) => setState(() {
                _selectedItemPosition = index;
              }),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'tickets',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.music_note,
                    ),
                    label: 'calendar'),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'calendar'),
              ],
              selectedLabelStyle: const TextStyle(fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: widgetlist[_selectedItemPosition]),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                right: 20,
                left: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          //login();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginView()),
                                        );
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Icon(
                                        Icons.logout,
                                        size: 20,
                                        color: Colors.white,
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
                    SizedBox(
                      height: 40,
                    ),
                    NewMusic(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewMusic extends StatelessWidget {
  const NewMusic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: [
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllSongsView(),
              ),
            );
          },
          image: 'Assets/Images/songs.jpg',
          text: "Songs",
        ),
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllArtistsView(),
              ),
            );
          },
          image: 'Assets/Images/artists.jpg',
          text: "Artists",
        ),
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopSongsView(),
              ),
            );
          },
          image: 'Assets/Images/pop.jpg',
          text: "Pop Music",
        ),
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HiphopSongsView(),
              ),
            );
          },
          image: 'Assets/Images/hiphop.jpg',
          text: "Hiphop Music",
        ),
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RapSongsView(),
              ),
            );
          },
          image: 'Assets/Images/rap.jpg',
          text: "Rap Music",
        ),
        Options(
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RomanticSongsView(),
              ),
            );
          },
          image: 'Assets/Images/romantic.jpg',
          text: "Romantic Music",
        ),
      ],
    );
  }
}

class Options extends StatelessWidget {
  Function ontap;
  String text;
  String image;

  Options({
    this.ontap,
    this.image,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  height: 80,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
