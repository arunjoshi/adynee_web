import 'package:flutter/material.dart';
import 'cta_button.dart';
import 'profile_widget.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [

          HeroText(),

          ProfileWidget()
        ],
      ),
    );
  }
}

class HeroText extends StatelessWidget {
  const HeroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

        Text(
          "Your inner confidence\nneeds space to grow",
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Color(0xFF57C7C2),
          ),
        ),

        SizedBox(height: 8),

        Text(
          "and training to thrive.",
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 40),

        CTAButton()
      ],
    );
  }
}