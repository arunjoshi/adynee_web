import 'package:adynee_web/model/APIResponse.dart';
import 'package:adynee_web/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/course_model.dart';
import '../../providers/training_form_view_model.dart';
import '../../utils/DialogHelper.dart';
import '../../utils/prefrence_service.dart';
import '../../widgets/ad_button.dart';
import '../../widgets/ad_textfield.dart';




class SaveUserEnrollFormPage extends StatefulWidget {
  final CourseModel course;
  const SaveUserEnrollFormPage({required this.course, super.key});

  @override
  State<SaveUserEnrollFormPage> createState() => _SaveUserEnrollFormPageState();
}

class _SaveUserEnrollFormPageState extends State<SaveUserEnrollFormPage> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final animalController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// TITLE
                Text(
                  "Before Enrollment, Please provide some basic details",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff59b6b2),
                  ),
                ),

                const SizedBox(height: 50),

                /// INPUT FIELDS
                CustomTextField(hint: "Full Name", controller: nameController,
                    validator  : (value) => Validator.validateEmpty(value, "Name")),
                const SizedBox(height: 20),

                CustomTextField(hint: "Mobile No.", controller: mobileController,
                  validator: Validator.validateMobile,
                  maxLength: 10,),
                const SizedBox(height: 20),

                CustomTextField(hint: "Email ID", controller:  emailController,
                    validator: Validator.validateEmail),
                const SizedBox(height: 20),

                CustomTextField(hint: "Favorite animal", controller:  animalController,),
                const SizedBox(height: 40),
                Text(
                  "Rs. ${widget.course.price}/-",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 40),

                Consumer<TrainingFormViewModel>(
                    builder: (context, vm, _) {
                      return CustomButton(
                        text: "Let's make payment",
                        width: 250,
                        height: 50,
                        isLoading: vm.isLoading,
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) return;

                          ApiResponse response = await vm.submitEnrollmentUserForm(
                            name: nameController.text,
                            mobile: mobileController.text,
                            email: emailController.text,
                            age: "",
                            animal: animalController.text,
                            context: context,
                            course: widget.course
                          );
                        },
                      );
                    }
                ),

                /// BUTTON
                /* InkWell(
                  onTap: (){
                    GoRouter.of(context).go('/show_video');

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Let's GO",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD WIDGET
  Widget buildField(String hint) {
    return Container(
      width: 550,
      decoration: BoxDecoration(
        color: const Color(0xff59b6b2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}