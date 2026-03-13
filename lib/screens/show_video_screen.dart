import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SurpriseVideoPage extends StatefulWidget {
  const SurpriseVideoPage({super.key});

  @override
  State<SurpriseVideoPage> createState() => _SurpriseVideoPageState();
}

class _SurpriseVideoPageState extends State<SurpriseVideoPage> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController.fromVideoId(
      videoId: "BTNUTtOPYuY", // replace with your youtube video id
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
  }

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
              "Here it is, at the end of the video\nwe have a Surprise for you !!!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: const Color(0xff59b6b2),
              ),
            ),

            const SizedBox(height: 50),

            /// VIDEO CONTAINER
            Container(
              width: 700,
              height: 350,
              decoration: BoxDecoration(
                color: const Color(0xff59b6b2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(1),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),

                child: YoutubePlayer(
                  controller: controller,
                  aspectRatio: 16 / 9,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// BUTTON
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Book Assesment",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}