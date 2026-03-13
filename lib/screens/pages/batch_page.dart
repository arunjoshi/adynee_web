import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../widgets/course_button.dart';
import '../../widgets/course_card.dart';

class BatchPage extends StatelessWidget {
  const BatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  AppColors.batch_bg_color,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {


          return Column(
            children: [

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CourseCard(
                    title: "MICRO COURSES",
                    courses: const [
                      "IELTS Crash Course",
                      "Interview Flight",
                      "Vocabulary Boost"
                    ],

                    indicatorColor: Colors.green,
                  ),

                  CourseCard(
                    title: "BATCHES",
                    courses: const [
                      "Fluent Rise",
                      "English Pro Formula",
                      "Orator Studio"
                    ],
                    indicatorColor: Colors.indigo,
                  ),

                  CourseCard(
                    title: "MEGA BATCHES",
                    courses: const [
                      "1-on-1 Training",
                      "Personality Development",
                      "Corporate English"
                    ],
                    indicatorColor: Colors.red,
                  ),
                ],
              ),



              const SizedBox(height: 70),

              HoverButton()
            ],
          );
        },
      ),
    );
  }
}