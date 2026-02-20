import 'dart:async';

import 'package:firebase/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();
    splash();
  }

  splash(){
    Timer(
      Duration(seconds: 4),() => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login(),)),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    body: Stack(children: [Center(child: Lottie.asset('assets/Adidas retro logo.json'))],),
    );
  }
}
