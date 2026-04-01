import 'package:adynee_web/screens/main_page.dart';
import 'package:adynee_web/widgets/ad_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:html' as html;

import '../utils/prefrence_service.dart';

class ConfirmationScreen extends StatefulWidget {
  final bool isAssessment;
  final String date;
  final String time;
  const ConfirmationScreen({super.key, required this.date, required this.time,required this.isAssessment,});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreen();
}

class _ConfirmationScreen extends State<ConfirmationScreen> {

  void disableBack() {
    html.window.history.pushState(null, '', html.window.location.href);
    html.window.onPopState.listen((event) {
      html.window.history.pushState(null, '', html.window.location.href);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: Container(
          width: 1000,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              widget.isAssessment ? Column(
                children: [
                  /// Title
                  const Text(
                    "Congratulations, Booking Confirmed!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5bb3b0),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "You had booked the slot for ${widget.date} at ${widget.time} successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  /// Subtitle
                  const Text(
                    "You will receive Joining Link 10 Minutes\nPrior to the Time of Assesment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ):  Text(
      "You had enrolled for the Course successfully \n You will get the batch details shortly on your email",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),





              const SizedBox(height: 40),

              /// Dark Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff0d1b3e),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [

                    const Text(
                      "Till then you can Sharpen your grammar skills\nwith just 5 minutes of reading",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Download Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xff5bb3b0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Download for FREE",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// Bottom Button
              CustomButton(text: "Explore our courses ",
                  isLoading: false,
                  onTap: (){
                    //GoRouter.of(context).go('/');
                    PreferencesService.setBool('lockHome', true);
                    context.go('/');
                    // GoRouter.of(context).go('/');
/*                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainPage()),
                          (route) => false,
                    );*/
                  },
               height: 50,
              width: 250,)
/*              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xff5bb3b0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Return to Home Screen ",
                  style: TextStyle(color: Colors.black),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}