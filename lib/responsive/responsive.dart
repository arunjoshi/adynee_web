import 'package:flutter/cupertino.dart';

class Responsive {

  static bool isMobile(context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1200 &&
          MediaQuery.of(context).size.width >= 800;

  static bool isDesktop(context) =>
      MediaQuery.of(context).size.width >= 1200;
}