import 'package:adynee_web/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.about_bg_color,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// LEFT TEXT
              Expanded(
                flex: 2,
                child: Text(
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(width: 80),

              /// RIGHT IMAGE
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0C2C4A),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF7FE0D6),
                      ),
                      child: const CircleAvatar(
                        radius: 120,
                        backgroundImage:
                        AssetImage("assets/images/profile_aa.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}