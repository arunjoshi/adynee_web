import 'package:adynee_web/screens/pages/about_page.dart';
import 'package:adynee_web/screens/pages/batch_page.dart';
import 'package:adynee_web/screens/pages/home_page.dart';
import 'package:adynee_web/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/nav_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedPage = 0;

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
              children: const [
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