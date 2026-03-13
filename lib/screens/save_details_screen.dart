import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingFormPage extends StatelessWidget {
  const TrainingFormPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// TITLE
              Text(
                "Enter your details to unlock\nFree 30-Minute Training",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff59b6b2),
                ),
              ),

              const SizedBox(height: 50),

              /// INPUT FIELDS
              buildField("Full Name"),
              const SizedBox(height: 20),

              buildField("Mobile No."),
              const SizedBox(height: 20),

              buildField("Email ID"),
              const SizedBox(height: 20),

              buildField("Favourite Animal"),
              const SizedBox(height: 40),

              /// BUTTON
              InkWell(
                onTap: (){
                  GoRouter.of(context).go('/show_video');

                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Let's GO",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
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

  /// INPUT FIELD WIDGET
  Widget buildField(String hint) {
    return Container(
      width: 550,
      decoration: BoxDecoration(
        color: const Color(0xff59b6b2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}