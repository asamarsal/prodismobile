import 'package:flutter/material.dart';
import 'package:prodis_mobile/pages/splashscreen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Memeriksa izin INTERNET
  var status = await Permission.storage;

  // Jika izin belum diberikan, maka minta izin
  if (status != PermissionStatus.granted) {
    await Permission.storage.request();
  }

  runApp(ProdisApp());
}

class ProdisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}