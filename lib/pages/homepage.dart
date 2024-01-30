import 'package:animate_gradient/animate_gradient.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<DateTime> timeStream;
  late DateTime currentTime;

  Map<String, dynamic> apiData = {};

  WebViewController? _controller;

  final _storage = FlutterSecureStorage();

  late String namauserdisimpan;
  late String jabatanuserdisimpan;
  late String leveluserdisimpan;
  late String iduserdisimpan;

  @override
  void initState() {
    super.initState();

    //Jam dan tanggal
    timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
          (count) => DateTime.now(),
    );

    //Inisialisasi currentTime dengan waktu sekarang
    currentTime = DateTime.now();

    //Baca Data Flutter Secure Storage saat inisialisasi
    namauserditampilkan();
    jabatanuserditampilkan();

    //Webview
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://sigula.sinergigula.com/simpgdbmobile/theme/login.php'));

  }

  //Baca Data Flutter Secure Storage
  Future<void> namauserditampilkan() async {
    namauserdisimpan = await _storage.read(key: 'namauserdisimpan') ?? 'Nama User';
    setState(() {});
  }
  Future<void> jabatanuserditampilkan() async {
    jabatanuserdisimpan = await _storage.read(key: 'jabatanuserdisimpan') ?? 'Jabatan User';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
            SafeArea(
              child: WebViewWidget(controller: _controller!),
            ),
      ),
    );
  }
}
