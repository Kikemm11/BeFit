/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:be_fit/servers/ProfileServer.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool profileExist;

  @override
  void initState() {
    super.initState();

    // Check profile existence
    _profileExists();

    // Initialize the animation controller and animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0.0, end: 1.2).animate(_controller);

    // Navigate to Home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (profileExist != null && profileExist){
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
      else{
        Navigator.pushNamedAndRemoveUntil(context, '/user-form', (route) => false);
      }

    });
  }

  // Check if profile already exists
  Future<void> _profileExists() async {
    profileExist = (await context.read<ProfileServer>().profileExists())!;
    setState(() {});
  }

  // Dispose the used controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Centered logo
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'lib/assets/be_fit_logo.png',
                width: 180,
                height: 180,
              ),
            ),
          ),
          // Powered by info
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'POWERED BY',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'César Maldonado\nAnyeli Calderón',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}