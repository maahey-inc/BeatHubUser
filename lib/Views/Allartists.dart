import 'dart:convert';
import 'dart:ui';

import 'package:beathubuser/Views/Artistssongs.dart';
import 'package:beathubuser/Views/mainplayerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllArtistsView extends StatefulWidget {
  @override
  _AllArtistsViewState createState() => _AllArtistsViewState();
}

class _AllArtistsViewState extends State<AllArtistsView> {
  bool searchon = false;
  String searchdata;
  List allartists = [];
  List filteredallartists = [];
  gettingdata() {
    FirebaseFirestore.instance.collection("artists").get().then((data) {
      //var datax = json.decode(data.docs.toString());
      //print(datax);
      setState(() {
        allartists = filteredallartists = data.docs;
        //print(allsongs["name"]);
      });
    });
  }

  void _filtersongs(value) {
    setState(() {
      print(value);

      filteredallartists = allartists
          .where((songs) =>
              songs['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();

      //print(filteredallsongs.length);
    });
  }

  @override
  void initState() {
    gettingdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  right: 20,
                  left: 20,
                ),
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
                                  child: searchon
                                      ? TextField(
                                          onChanged: (value) {
                                            _filtersongs(value);
                                          },
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Search Song",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Artists",
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
                                      setState(() {
                                        searchon = !searchon;
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
                                        searchon ? Icons.close : Icons.search,
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
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredallartists.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArtistAllSongsView(
                                        name: filteredallartists[index]["name"],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              filteredallartists[index]
                                                  ["image"],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        filteredallartists[index]["name"],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    //NewMusic(),
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
