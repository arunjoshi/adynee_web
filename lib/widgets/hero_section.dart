import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import 'cta_button.dart';
import 'profile_widget.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);



    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: isMobile
        ? _mobileLayout()
        : _desktopLayout(),/*Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [

          HeroText(),

          ProfileWidget()
        ],
      ),*/
    );
  }
}

/// DESKTOP
Widget _desktopLayout() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [

      HeroText(),

      ProfileWidget()
    ],
  );
}

/// MOBILE
Widget _mobileLayout() {
  return SingleChildScrollView(
    child: Column(
      children: [

        HeroText(),

        const SizedBox(height: 30),

        ProfileWidget(),
      ],
    ),
  );
}

class HeroText extends StatelessWidget {
  const HeroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

         SizedBox(height: Responsive.isMobile(context) ? 40 : 0,),

        Text(
          "Your inner confidence\nneeds space to grow",
          style: TextStyle(
            fontSize: Responsive.isMobile(context)
                ? 30
                : 44,
            fontWeight: FontWeight.bold,
            color: Color(0xFF57C7C2),
          ),
        ),

        SizedBox(height: 8),

        Text(
          "and training to thrive.",
          style: TextStyle(
            fontSize: Responsive.isMobile(context)
                ? 30
                : 44,
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