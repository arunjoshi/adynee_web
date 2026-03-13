import 'package:adynee_web/responsive/screen_size.dart';
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          width: Responsive.isMobile(context) ? ScreenSize.width*0.35 : ScreenSize.width*0.25,
          height: Responsive.isMobile(context) ? ScreenSize.width*0.35 : ScreenSize.width*0.25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/profile.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "Thats me ssss!!",
          style: TextStyle(

            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}