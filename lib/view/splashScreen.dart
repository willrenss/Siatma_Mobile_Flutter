import 'package:flutter/material.dart';
import 'package:siatma_mobile/view/dashboardScreen.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: DashboardScreen(false),
      duration: 3500,
      imageSize: 225,
      imageSrc: "assets/images/UAJY_Logo.png",
      text: "SIATMA",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 50.0, fontFamily: "Fugaz"),
      colors: [
        Colors.white,
        Colors.white,
        Colors.blue[900],
        Colors.yellow[700],
        Colors.white,
      ],
      backgroundColor: Colors.blue[900],
    );
  }
}
