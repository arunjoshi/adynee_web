import 'package:adynee_web/model/course_model.dart';
import 'package:adynee_web/providers/main_form_view_model.dart';
import 'package:adynee_web/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../responsive/responsive.dart';
import '../../utils/app_colors.dart';
import '../../widgets/course_button.dart';
import '../../widgets/course_card.dart';

class BatchPage extends StatelessWidget {


  BatchPage({ super.key});

/*
  final Map<String, List<String>> data = {
    "MICRO COURSES": [
      "IELTS Crash Course",
      "Interview Flight",
      "Vocabulary Boost"
    ],
    "BATCHES": [
      "Fluent Rise",
      "English Pro Formula",
      "Orator Studio"
    ],
    "MEGA BATCHES": [
      "1-on-1 Training",
      "Personality Development",
      "Corporate English"
    ],
    "STANDARD COURSES": [
      "Communication Essentials",
      "Professional English",
      "Mini Personality Development",
      "Executive Communication"
    ],
  };*/

  final Map<String, Color> colors = {
    "39ae0631-b362-4674-bb4d-86922be6a959": Colors.green,
    "6bfecfd4-b95d-4a28-9a4a-cc536dad09c8": Colors.indigo,
    "5ee1aaf9-8822-46b8-a562-3ed55fe2f87e": Colors.red,
    "71b2e066-86e6-40bb-8b61-702401fc314c": Colors.purple,
  };


  @override
  Widget build(BuildContext context) {

    bool isMobile = Responsive.isMobile(context);
    return isMobile ?  _mobileLayout()
    : _desktopLayout();
  }

  String getCategory(String spId) {
    if (spId == "71b2e066-86e6-40bb-8b61-702401fc314c" ||
        spId == "39ae0631-b362-4674-bb4d-86922be6a959") {
      return "MICRO COURSES";
    } else if (spId == "6bfecfd4-b95d-4a28-9a4a-cc536dad09c8") {
      return "MEGA BATCHES";
    } else if (spId == "5ee1aaf9-8822-46b8-a562-3ed55fe2f87e") {
      return "STANDARD COURSES";
    } else {
      return "BATCHES";
    }
  }


  /// DESKTOP
  Widget _desktopLayout() {
    return Consumer<MainFormViewModel>(
        builder: (context, mainFormViewModel, _) {

          if (mainFormViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            color:  AppColors.batch_bg_color,
            width: ScreenSize.width,
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            child: Column(
              children: [
                /// CARDS
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mainFormViewModel.groupedCourses.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CourseCard(
                          title: getCategory(entry.key),
                          courses: entry.value,
                          indicatorColor: colors[entry.key]!,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 70),

                HoverButton()
              ],
            ),
          );
        });

  }

  /// MOBILE
  Widget _mobileLayout() {




    return Consumer<MainFormViewModel>(
        builder: (context, mainFormViewModel, _) {

          if (mainFormViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
            color:  AppColors.batch_bg_color,
            width: ScreenSize.width,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         CourseCard(
                //           title: "MICRO COURSES",
                //           courses: const [
                //             "IELTS Crash Course",
                //             "Interview Flight",
                //             "Vocabulary Boost"
                //           ],
                //
                //           indicatorColor: Colors.green,
                //         ),
                //         SizedBox(height:  20,),
                //
                //         CourseCard(
                //           title: "BATCHES",
                //           courses: const [
                //             "Fluent Rise",
                //             "English Pro Formula",
                //             "Orator Studio"
                //           ],
                //           indicatorColor: Colors.indigo,
                //         ),
                //         SizedBox(height:  20,),
                //         CourseCard(
                //           title: "MEGA BATCHES",
                //           courses: const [
                //             "1-on-1 Training",
                //             "Personality Development",
                //             "Corporate English"
                //           ],
                //           indicatorColor: Colors.red,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mainFormViewModel.groupedCourses.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CourseCard(
                          title: getCategory(entry.key),
                          courses: entry.value,
                          indicatorColor: colors[entry.key]!,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),

                HoverButton()
              ],
            ),
          );
        });

  }

}