import 'package:adynee_web/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/hero_section.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.home_bg_color,
      body: Column(
        children: const [

       //   Navbar(),

          Expanded(
            child: HeroSection(),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              "ADYNEE",
              style: TextStyle(
                color: Color(0xFF57C7C2),
                fontSize: 26,
                letterSpacing: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}