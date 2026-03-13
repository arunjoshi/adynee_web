import 'package:adynee_web/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../responsive/responsive.dart';
import '../../responsive/screen_size.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});



  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.about_bg_color,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 200,
            vertical: 40,
          ),

          child: isMobile
              ? _mobileLayout()
              : _desktopLayout(),
        ),
      ),
    );
  }

  /// DESKTOP
  Widget _desktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        /// TEXT
        Expanded(
          flex: 2,
          child: _aboutText(),
        ),

        const SizedBox(width: 80),

        /// IMAGE
        Expanded(
          flex: 1,
          child: Center(child: _profileImage()),
        ),
      ],
    );
  }

  /// MOBILE
  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
      
          _profileImage(),
      
          const SizedBox(height: 30),
      
          _aboutText(),
        ],
      ),
    );
  }

  /// TEXT
  Widget _aboutText() {
    return const Text(
      """
I’m Aditi Jaiswal, Director and Chief Trainer at
Adynee (by British Academy), Indore. With over 17
years of experience, I specialize in English
language training, Communication Skills, IELTS
preparation, and Personality Development.

As a British Council Certified Trainer for IELTS,
TOEFL, GRE, and SAT, I’ve guided learners from
diverse backgrounds worldwide. My approach is
practical and results-driven, focused on real-world
application and building true confidence.

I’ve also led corporate training programs and
workshops for professionals including teachers,
nurses, engineers, managers, and students. At
Adynee, we are committed to delivering impactful,
supportive, and high-quality training that helps
individuals and organizations achieve their goals
and unlock their full potential.
""",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        height: 1.6,
      ),
    );
  }

  /// IMAGE
  Widget _profileImage() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF0C2C4A),
      ),
       child:  Container(
          width: ScreenSize.width * 0.4,
          height: ScreenSize.width * 0.4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/profile_aa.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
        )
      /*child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF7FE0D6),
        ),
        child: ClipOval(
          child: Image.asset(
            "assets/images/profile_aa.png",
          
            width: ScreenSize.width * 0.3,
            height:ScreenSize.width * 0.2 ,
            fit: BoxFit.cover,
          ),
        ),
      ),*/
    );
  }
}