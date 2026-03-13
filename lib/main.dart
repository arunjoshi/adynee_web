import 'package:adynee_web/responsive/screen_size.dart';
import 'package:adynee_web/screens/main_page.dart';
import 'package:adynee_web/screens/save_details_screen.dart';
import 'package:adynee_web/screens/show_video_screen.dart';
import 'package:adynee_web/screens/training_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return MaterialApp.router(
      title: 'Adynee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      routerConfig: _router,

    );
  }

  // Configure routes using GoRouter
  final GoRouter _router = GoRouter(

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: '/training_video',
        builder: (context, state) => TrainingVideoPreview(),
      ),
      GoRoute(
        path: '/save_details',
        builder: (context, state) => TrainingFormPage(),
      ),
      GoRoute(
        path: '/show_video',
        builder: (context, state) => SurpriseVideoPage(),
      ),


    ],
  );
}