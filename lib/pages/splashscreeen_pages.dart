import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color.dart';

class SplashscreenPages extends StatefulWidget {
  const SplashscreenPages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashscreenPagesState createState() => _SplashscreenPagesState();
}

class _SplashscreenPagesState extends State<SplashscreenPages> {
  @override
  void initState() {
    super.initState();

    // Menjalankan timer selama 2 detik
    Timer(const Duration(seconds: 2), () {
      // Navigasi ke halaman selanjutnya
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_mylook.png',
              alignment: Alignment.bottomCenter,
              height: 500,
              width: 500, // Sesuaikan dengan tinggi yang diinginkan
            ),
          ],
        ),
      ),
    );
  }
}
