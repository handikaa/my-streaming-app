import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../component/assets.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.splashImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: LottieBuilder.asset(Assets.movieLt, width: 250, height: 250),
          ),
        ],
      ),
    );
  }
}
