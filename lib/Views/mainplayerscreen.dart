import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:just_audio/just_audio.dart';
//import 'package:music_player_flutter/Components/Custombutton.dart';

class MainPlayer extends StatefulWidget {
  String cover;
  String name;
  String artist;
  String songlink;
  MainPlayer({this.artist, this.cover, this.name, this.songlink});
  @override
  _MainPlayerState createState() => _MainPlayerState();
}

class _MainPlayerState extends State<MainPlayer> {
  double slidervalue = 0.0;
  double volume = 0;
  final player = AudioPlayer();

  @override
  void initState() {
    // if (player.playing) {
    //   print("alreadyplaying");
    //   player.stop();
    // }
    player.setUrl(widget.songlink);
    player.play();
    //player.setVolume(10);
    // player.playerStateStream.listen((state) {
    //   if (state.playing) {
    //     print("playing");
    //   } else
    //     player.play();
    //   switch (state.processingState) {
    //     case ProcessingState.idle:
    //       return print("idle");
    //     case ProcessingState.loading:
    //       return print("playing");
    //     case ProcessingState.buffering:
    //       return print("playing");
    //     case ProcessingState.ready:
    //       return print("ready");
    //     case ProcessingState.completed:
    //       print("playing");
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.cover == null
                ? AssetImage("Assets/Images/dj.jpg")
                : NetworkImage(widget.cover),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              color: Color(0xFF000000).withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          //flex: 6,
                          child: Column(
                            children: [
                              Icon(Icons.arrow_downward),
                              //SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Now Playing',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: RawMaterialButton(
                              //padding: EdgeInsets.symmetric(horizontal: 40),
                              fillColor: Color(0xFF4C4F5E),
                              child: Icon(Icons.favorite_border),
                              onPressed: () {},
                              constraints: BoxConstraints.tightFor(
                                height: 50,
                                width: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: widget.cover == null
                                    ? AssetImage("Assets/Images/dj.jpg")
                                    : NetworkImage(widget.cover),
                                //radius: 130,
                                radius: MediaQuery.of(context).size.height / 6,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.height / 24,
                                backgroundColor: Color(0xff1f2229),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.name ?? "",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.artist ?? "",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[400],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          // SliderTheme(
                          //   data: SliderTheme.of(context).copyWith(
                          //     trackHeight: 1,
                          //     inactiveTrackColor: Color(0xFF42425f),
                          //     activeTrackColor: Color(0xFF7422FB),
                          //     thumbColor: Color(0xFFEB1555),
                          //     overlayColor: Color(0x29EB1555),
                          //     thumbShape: RoundSliderThumbShape(
                          //         enabledThumbRadius: 0.0),
                          //     overlayShape:
                          //         RoundSliderOverlayShape(overlayRadius: 10.0),
                          //   ),
                          //   child: Container(
                          //     width: 300,
                          //     child: Slider(
                          //       min: 0.0,
                          //       max: 220.0,
                          //       value: slidervalue,
                          //       onChanged: (double newvalue) {
                          //         setState(() {
                          //           slidervalue = newvalue;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   //color: Colors.grey,
                          //   width: 280,
                          //   child: Row(
                          //     //crossAxisAlignment: CrossAxisAlignment.stretch,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('00:00'),
                          //       Text('03:45'),
                          //     ],
                          //   ),
                          // ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // RawButton(
                                //   width:
                                //       MediaQuery.of(context).size.height / 22,
                                //   height:
                                //       MediaQuery.of(context).size.height / 22,
                                //   icon: Icons.replay,
                                //   iconsize:
                                //       MediaQuery.of(context).size.height / 30,
                                //   iconcolor: Colors.white,
                                //   onpressed: () {},
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(
                                //       Radius.circular(15),
                                //     ),
                                //   ),
                                // ),
                                // RawButton(
                                //   width:
                                //       MediaQuery.of(context).size.height / 22,
                                //   height:
                                //       MediaQuery.of(context).size.height / 22,
                                //   icon: Icons.skip_previous,
                                //   iconsize:
                                //       MediaQuery.of(context).size.height / 30,
                                //   iconcolor: Colors.grey[500],
                                //   onpressed: () {},
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(
                                //       Radius.circular(15),
                                //     ),
                                //   ),
                                // ),
                                RawMaterialButton(
                                  elevation: 5.0,
                                  //fillColor: Color(0xFF7422FB),
                                  child: Icon(
                                    Icons.fast_rewind,
                                    color: Colors.grey[500],
                                    size:
                                        MediaQuery.of(context).size.height / 30,
                                  ),
                                  onPressed: () {
                                    player.seek(Duration(seconds: -10));
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    height:
                                        MediaQuery.of(context).size.height / 22,
                                    width:
                                        MediaQuery.of(context).size.height / 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF7422FB),
                                        blurRadius: 7,
                                        offset: Offset(0.0, 3),
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: RawMaterialButton(
                                    elevation: 5.0,
                                    fillColor: Color(0xFF7422FB),
                                    child: Icon(
                                      player.playing
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (player.playing) {
                                        setState(() {
                                          player.pause();
                                        });
                                      } else {
                                        setState(() {
                                          player.play();
                                        });
                                      }
                                    },
                                    constraints: BoxConstraints.tightFor(
                                      height: 50,
                                      width: 50,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                RawMaterialButton(
                                  elevation: 5.0,
                                  //fillColor: Color(0xFF7422FB),
                                  child: Icon(
                                    Icons.fast_forward,
                                    color: Colors.grey[500],
                                    size:
                                        MediaQuery.of(context).size.height / 30,
                                  ),
                                  onPressed: () {
                                    player.seek(Duration(seconds: 60));
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    height:
                                        MediaQuery.of(context).size.height / 22,
                                    width:
                                        MediaQuery.of(context).size.height / 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                // RawButton(
                                //   onpressed: () {},
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(
                                //       Radius.circular(15),
                                //     ),
                                //   ),
                                //   width:
                                //       MediaQuery.of(context).size.height / 22,
                                //   height:
                                //       MediaQuery.of(context).size.height / 22,
                                //   icon: Icons.skip_next,
                                //   iconcolor: Colors.grey[500],
                                //   iconsize:
                                //       MediaQuery.of(context).size.height / 30,
                                // ),
                                // RawButton(
                                //   width:
                                //       MediaQuery.of(context).size.height / 22,
                                //   height:
                                //       MediaQuery.of(context).size.height / 22,
                                //   icon: Icons.list,
                                //   iconsize:
                                //       MediaQuery.of(context).size.height / 30,
                                //   iconcolor: Colors.white,
                                //   onpressed: () {},
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(
                                //       Radius.circular(15),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: 500,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    player.setVolume(0);
                                  },
                                  child: Icon(Icons.volume_off),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    inactiveTrackColor: Color(0xFF42425f),
                                    activeTrackColor: Color(0xFFFFFFFF),
                                    thumbColor: Color(0xFFFFFFFF),
                                    overlayColor: Color(0xFFFFFFFF),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 6.0),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 10.0),
                                  ),
                                  child: Container(
                                    width: 300,
                                    child: Slider(
                                      divisions: 10,
                                      min: 0.0,
                                      max: 10.0,
                                      value: player.volume,
                                      onChanged: (double newvalue) {
                                        setState(() {
                                          volume = newvalue;
                                          player.setVolume(volume);
                                          print(volume);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    player.setVolume(volume);
                                  },
                                  child: Icon(
                                    Icons.volume_up,
                                    color: Color(0xFF7422FB),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
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

class RawButton extends StatelessWidget {
  final IconData icon;
  final Color iconcolor;
  final double iconsize;
  final Function onpressed;
  final double height;
  final double width;
  final ShapeBorder shape;

  RawButton(
      {this.icon,
      this.iconcolor,
      this.iconsize,
      @required this.onpressed,
      this.height,
      this.width,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 5.0,
      child: Icon(
        icon,
        color: iconcolor,
        size: iconsize,
      ),
      onPressed: () {},
      constraints: BoxConstraints.tightFor(
        height: height,
        width: width,
      ),
      shape: shape,
    );
  }
}
