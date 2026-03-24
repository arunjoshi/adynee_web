import 'package:adynee_web/model/APIResponse.dart';
import 'package:adynee_web/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/training_form_view_model.dart';
import '../utils/DialogHelper.dart';
import '../utils/prefrence_service.dart';
import '../widgets/ad_button.dart';
import '../widgets/ad_textfield.dart';


class TrainingFormPage extends StatefulWidget {
  const TrainingFormPage({super.key});

  @override
  State<TrainingFormPage> createState() => _TrainingFormPageState();
}

class _TrainingFormPageState extends State<TrainingFormPage> {

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
                  "Enter your details to unlock\nFree 30-Minute Training",
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

                CustomTextField(hint: "Age", controller:  animalController,),
                const SizedBox(height: 40),

                Consumer<TrainingFormViewModel>(
                  builder: (context, vm, _) {
                    return CustomButton(
                      text: "Let's GO",
                      width: 250,
                      height: 50,
                      isLoading: vm.isLoading,
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) return;

                        ApiResponse response = await vm.submitForm(
                          name: nameController.text,
                          mobile: mobileController.text,
                          email: emailController.text,
                          age: animalController.text,
                          animal: "",
                        );

                       /* bool success = await vm.submitForm(
                          name: nameController.text,
                          mobile: mobileController.text,
                          email: emailController.text,
                          animal: animalController.text,
                        );*/

                        if (response.status == "success") {

                          DialogHelper.showAppDialog(context: context, isSuccess: true, title: "Sucess", message: "Your registration is scucessfull, please watch video",
                          onOk: () async{
                            if (response.data is Map<String, dynamic>) {
                              String userId = response.data['user_id'];
                              await PreferencesService.setUserId("${userId}");
                              GoRouter.of(context).go('/show_video');
                            }
                          });


                        }else{
                          DialogHelper.showAppDialog(context: context, isSuccess: false, title: "error", message: response.message,);

                          }
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