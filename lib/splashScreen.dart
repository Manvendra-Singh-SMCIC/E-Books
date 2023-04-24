// ignore_for_file: file_names, use_build_context_synchronously

import 'package:book_reader_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 4000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          alignment: const Alignment(0,1),
          child: OverflowBox(
            // child: AnimatedSplashScreen(
            //   splash: Lottie.network(
            //     "https://assets4.lottiefiles.com/packages/lf20_D7l6QPTtOL.json",
            //     fit: BoxFit.cover,
            //   ),
            //   splashTransition: SplashTransition.scaleTransition,
            //   pageTransitionType: PageTransitionType.fade,
            //   nextScreen: const HomePage(),
            //   duration: 3000,
            // ),
            child: Lottie.network(
                "https://assets4.lottiefiles.com/packages/lf20_D7l6QPTtOL.json",
                fit: BoxFit.cover,
              ),
          ),
        ),
      ),
    );
  }
}
