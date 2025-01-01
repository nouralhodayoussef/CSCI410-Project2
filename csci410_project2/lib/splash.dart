import 'package:csci410_project2/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('imgs/logo.png'),
      title: Text(
        'Car Gallery',
        style: TextStyle(
          color: const Color.fromARGB(255, 20, 82, 113),
          fontFamily: 'ro',
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: const Color.fromARGB(255, 20, 82, 113),
      navigator: Homepage(),
      durationInSeconds: 3,
    );
  }
}
