import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'course_button.dart';

class CourseCard extends StatefulWidget {

  final String title;
  final List<String> courses;
  final Color indicatorColor;
  final String? highlight;

  const CourseCard({
    super.key,
    required this.title,
    required this.courses,
    required this.indicatorColor,
    this.highlight,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(

      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black26),
          color: Colors.white.withOpacity(hovering ? 0.9 : 0.8),
          boxShadow: hovering
              ? [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 6),
            )
          ]
              : [],
        ),

        child: Column(
          children: [

            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xff59b6b2),
              ),
            ),

            const SizedBox(height: 25),

            ...widget.courses.map((course) => CourseButton(
              title: course,
              highlighted: widget.highlight == course,
            )),

            const SizedBox(height: 20),

            Container(
              height: 10,
              width: 70,
              decoration: BoxDecoration(
                color: widget.indicatorColor,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}