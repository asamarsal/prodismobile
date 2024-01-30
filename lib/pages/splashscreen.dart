import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:prodis_mobile/pages/tampilandepanpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  _navigateToDashboard() async {
    await Future.delayed(Duration(milliseconds: 3000));

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TampilandepanPage())
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimateGradient(
              primaryColors: const [
                Color(0xFF090E30),
                Color(0xFF090E30),
                Color(0xFF090E30),
              ],
              secondaryColors: const [
                Color(0xFF315FA7),
                Color(0xFF315FA7),
                Color(0xFF315FA7),
              ],
              child: Container(
                decoration: const BoxDecoration(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logosgnhd.png',
                            width: 250,
                          ),
                          SizedBox(height: 20.0,),
                          const Text(
                            'Prodis',
                            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500,),
                          ),
                          const Text(
                            'by Sinergi Gula Nusantara',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400,),
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
