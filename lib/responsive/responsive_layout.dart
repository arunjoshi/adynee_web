import 'package:adynee_web/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {

    if (Responsive.isDesktop(context)) {
      return desktop;
    }

    if (Responsive.isTablet(context)) {
      return tablet;
    }

    return mobile;
  }
}