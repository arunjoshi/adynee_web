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
    return MaterialApp.router(
      title: 'Adynee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      routerConfig: _router,


      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: ResponsiveScaledBox(
          width: 1200,
          child: child!,
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),

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