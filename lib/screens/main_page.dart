import 'package:adynee_web/model/course_model.dart';
import 'package:adynee_web/providers/main_form_view_model.dart';
import 'package:adynee_web/screens/pages/about_page.dart';
import 'package:adynee_web/screens/pages/batch_page.dart';
import 'package:adynee_web/screens/pages/home_page.dart';
import 'package:adynee_web/utils/DialogHelper.dart';
import 'package:adynee_web/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../model/APIResponse.dart';
import '../widgets/nav_item.dart';
import 'dart:html' as html;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedPage = 0;

  void disableBack() {
    html.window.history.pushState(null, '', html.window.location.href);
    html.window.onPopState.listen((event) {
      html.window.history.pushState(null, '', html.window.location.href);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disableBack();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm  =  Provider.of<MainFormViewModel>(context, listen: false);
      if (!vm.isDataLoaded) {
        vm.fetchCourses(context);
      }

          //.fetchCourses(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          /// NAVBAR (Fixed)
          _navBar(),

          /// CONTENT CHANGE
          Expanded(
            child: IndexedStack(
              index: selectedPage,
              children: [
                HomePage(),
                AboutPage(),
                BatchPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navBar() {

    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    return Container(
      color: selectedPage == 1 ?  AppColors.about_bg_color :
      selectedPage == 2 ?  AppColors.batch_bg_color  :
      AppColors.home_bg_color ,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            NavItem(
              text: "About",

              onTap: () {
                setState(() {
                  selectedPage = 1;
                });
              },
            ),

            const SizedBox(width: 50),

            InkWell(
              child: Image.asset(
                selectedPage == 1 ? "assets/images/logo_white.png" : "assets/images/logo.png",
                height: 55,
              ),
              onTap: (){
                setState(() {
                  selectedPage = 0;
                });
              },
            ),

            const SizedBox(width: 50),


            NavItem(

              text: "Batches",
              onTap: () {
                setState(() {
                  selectedPage = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


}
