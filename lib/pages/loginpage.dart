import 'dart:convert';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void login(String username, String password) async {

    try {
      final response = await http.post(
        Uri.parse('https://sigula.sinergigula.com/index.php/api/loginmobile'),
        body: {
          'nohp': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {

        var data = jsonDecode(response.body.toString());

        if (data['status'] == 1) {

          // Pindah ke halaman beranda
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteTransitionBuilder(page: const HomePage(), effect: TransitionEffect.scale),
                (route) => false,
          );

          //Ambil data dari API
          String idUser = data['data']['id'];
          String levelUser = data['data']['level'];
          String namaUser = data['data']['nama'];
          String jabatanUser = data['data']['jabatan'];

          // Menyimpan data login ke (flutter secure storage)
          final _storage = FlutterSecureStorage();

          // Menyimpan data password ke (flutter secure storage)
          await _storage.write(key: 'iduserdisimpan', value: idUser);
          await _storage.write(key: 'leveluserdisimpan', value: levelUser);
          await _storage.write(key: 'namauserdisimpan', value: namaUser);
          await _storage.write(key: 'jabatanuserdisimpan', value: jabatanUser);

        }
      }
      else if (response.statusCode == 401) {

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Username / Password Anda Salah",
          ),
        );

      }
    } catch (e) {
      print(e.toString());
    }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundutama.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logosgnhd.png',
                  width: 250,
                ),
                SizedBox(height: 40.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: usernameController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number, // Set jenis keyboard menjadi numeric
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // Hanya memperbolehkan angka
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Nomor Handphone',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: passwordController,
                    textAlign: TextAlign.left,
                    obscureText: !isPasswordVisible,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      // Validasi input sebelum melakukan login
                      if (usernameController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        // Menampilkan snackbar jika username atau password kosong
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: "Harap Isi Username dan Password",
                          ),
                        );
                      }
                      else if (usernameController.text.isEmpty) {
                        // Menampilkan snackbar jika username atau password kosong
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: "Harap Isi Username",
                          ),
                        );
                      }
                      else if (passwordController.text.isEmpty) {
                        // Menampilkan snackbar jika username atau password kosong
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: "Harap Isi Password",
                          ),
                        );
                      }
                      else {
                        // Melakukan login jika kedua input terisi
                        login(
                          usernameController.text.toString(),
                          passwordController.text.toString(),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xFF315FA7),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
