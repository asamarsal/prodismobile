import 'package:animate_gradient/animate_gradient.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'dart:async';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:http/http.dart' as http;
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<DateTime> timeStream;
  late DateTime currentTime;


  @override
  void initState() {
    super.initState();
    timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
          (count) => DateTime.now(),
    );

    // Inisialisasi currentTime dengan waktu sekarang
    currentTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                    height: 50.0,
                    color: Color(0xFF090E30), // Tambahkan properti color di sini
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0.0, right: 10.0,),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // Handle onTap event
                                  },
                                  child: AvatarView(
                                    radius: 20,
                                    borderColor: Color(0xFF090E30),
                                    borderWidth: 1,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath: "https://i.ibb.co/T2MXSYT/sgnupload2.png",
                                    placeHolder: Container(
                                      child: Icon(Icons.person, size: 40,),
                                    ),
                                    errorWidget: Container(
                                      child: Icon(Icons.error, size: 40,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('userName',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                              SizedBox(height: 5.0),
                              Text('userDivisi',
                                style: TextStyle(fontSize: 12.0, color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              StreamBuilder<DateTime>(
                                stream: timeStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    currentTime = snapshot.data!;
                                  }
                                  final formattedTime = DateFormat('HH:mm:ss').format(currentTime);
                                  final formattedDate = DateFormat('dd MMMM y').format(currentTime);
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          formattedTime,
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          formattedDate,
                                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}