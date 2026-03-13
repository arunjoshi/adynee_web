import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/profile.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "Thats me ssss!!",
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}