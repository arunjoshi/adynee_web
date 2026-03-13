import 'package:flutter/material.dart';

class CTAButton extends StatefulWidget {
  const CTAButton({super.key});

  @override
  State<CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<CTAButton> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 420,
        height: 70,
        decoration: BoxDecoration(
          color: hovering ? Colors.white : const Color(0xFFE7E7E7),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [

            const SizedBox(width: 25),

            const Expanded(
              child: Text(
                "Watch this free 30-minute\ntraining to learn how",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(8),
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF57C7C2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}