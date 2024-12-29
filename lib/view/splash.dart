import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // super.initState();
    Future.delayed(const Duration(seconds: 05),
        () => {Navigator.pushReplacement(context, createRoute())});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // #002D62
      backgroundColor: Color(0xFF0002D62),
      body: Center(
        child: Container(
          child: Lottie.asset('assets/Animation - 1735284550426.json'),
        ),
      ),
    );
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
