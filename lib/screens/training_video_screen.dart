import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingVideoPreview extends StatelessWidget {
  const TrainingVideoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// TITLE
            Text(
              "Watch This Free 30-Minute Training",
              style: GoogleFonts.poppins(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: const Color(0xff59b6b2),
              ),
            ),

            const SizedBox(height: 10),

            /// SUBTITLE
            Text(
              "Before Joining Any English Course",
              style: GoogleFonts.poppins(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "How Working Professionals Improve Fluency Without\n"
                  "Grammar Overload or Memorizing Vocabulary Lists",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 60),

            /// VIDEO THUMBNAIL
            GestureDetector(
              onTap: () {
                // action when clicked
                print("Play video");
                GoRouter.of(context).go('/save_details');

              },

              child: Stack(
                alignment: Alignment.center,

                children: [

                  /// VIDEO CARD
                  Container(
                    width: 700,
                    height: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xff59b6b2),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),

                  /// PLAY ICON
                  const Icon(
                    Icons.play_arrow_rounded,
                    size: 250,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}