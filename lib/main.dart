import 'package:adynee_web/providers/training_form_view_model.dart';
import 'package:adynee_web/responsive/screen_size.dart';
import 'package:adynee_web/screens/assesment_book_screen.dart';
import 'package:adynee_web/screens/confirmation_screen.dart';
import 'package:adynee_web/screens/main_page.dart';
import 'package:adynee_web/screens/payment_screen.dart';
import 'package:adynee_web/screens/save_details_screen.dart';
import 'package:adynee_web/screens/show_video_screen.dart';
import 'package:adynee_web/screens/training_video_screen.dart';
import 'package:adynee_web/utils/prefrence_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TrainingFormViewModel(),
          ),
        ],
        child: MyApp(),
      )
      );
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

      GoRoute(
        path: '/book_assesment',
        builder: (context, state) => BookingScreen(),
      ),

      GoRoute(
        path: '/payment',
        builder: (context, state) => PaymentScreen(),
      ),
      GoRoute(
        path: '/confirmation',
        builder: (context, state) => ConfirmationScreen(),
      ),

    ],
  );
}