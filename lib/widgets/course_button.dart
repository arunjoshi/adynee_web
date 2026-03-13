import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseButton extends StatefulWidget {

  final String title;
  final bool highlighted;

  const CourseButton({
    super.key,
    required this.title,
    this.highlighted = false,
  });

  @override
  State<CourseButton> createState() => _CourseButtonState();
}

class _CourseButtonState extends State<CourseButton> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(

      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: widget.highlighted
              ? const Color(0xff59b6b2)
              : hovering
              ? Color(0xff59b6b2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black26),
        ),

        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: hovering ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}


class HoverButton extends StatefulWidget {
  const HoverButton({super.key});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        GoRouter.of(context).go('/training_video');
      },
      child: MouseRegion(

        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),

          decoration: BoxDecoration(
            color: hovering
                ? const Color(0xff49a9a5)
                : const Color(0xff59b6b2),
            borderRadius: BorderRadius.circular(25),
          ),

          child: Text(
            "Confused ?..watch free training",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}