import 'package:adynee_web/utils/DialogHelper.dart';
import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';
import '../model/APIResponse.dart';
import '../model/course_model.dart';

class MainFormViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  //List<CourseModel> courseList = [];
  bool isLoading = true;
  Map<String, List<CourseModel>> groupedCourses = {};
  bool isDataLoaded = false;


  Future<void> fetchCourses(BuildContext buildContext) async {

    try{
      isLoading = true;
      DialogHelper.showLoader(buildContext);
      final ApiService _apiService = ApiService();

      final apiResponse = await _apiService.getCourses();


      var data = apiResponse.data['data'];
      List<CourseModel> courseList = data
          .where((e) => e['isActive'] == true)
          .map<CourseModel>((e) => CourseModel.fromJson(e))
          .toList();


      print("courselist length :- ${courseList.length}");
      for (int i = 0; i < courseList.length; i++) {
        final spId = courseList[i].sp_id;
        print("ppqpqpqp  $i ----- ${spId}");

        if (!groupedCourses.containsKey(spId)) {
          groupedCourses[spId] = [];
        }

        groupedCourses[spId]!.add(courseList[i]);
      }
      isDataLoaded = true; // 👈 mark done
      isLoading = false;
      notifyListeners();

      DialogHelper.hideLoader(buildContext);

    }catch(ex, stack){
      isLoading = false;
      print("Exception :- ${ex} --  ${stack}");
      DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "${ex.toString()}", isSuccess: false);
      DialogHelper.hideLoader(buildContext);
    }
   }


  void groupCourses(List<CourseModel> courses) {
    for (int i = 0; i < courses.length; i++) {
      final spId = courses[i].sp_id;

      if (!groupedCourses.containsKey(spId)) {
        groupedCourses[spId] = [];
      }

      groupedCourses[spId]?.add(courses[i]);
    }
  }

  int selectedPage = 0;

  void setPage(int index) {
    selectedPage = index;
    notifyListeners();
  }


}