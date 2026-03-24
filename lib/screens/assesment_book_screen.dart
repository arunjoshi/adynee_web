import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/prefrence_service.dart';
import '../widgets/ad_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});



  @override
  State<BookingScreen> createState() => _BookingScreenState();
}


class _BookingScreenState extends State<BookingScreen> {
  String? selectedTime;
  String? userId;
  DateTime? selectedDate;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = PreferencesService.getUserId(); // no await needed (your method is sync)
    print("Updated UserId :- $userId");

    setState(() {}); // update UI if needed
  }


  final List<String> times = [
    "12:00 noon",
    "3:00 pm",
    "5:00 pm",
    "6:00 pm"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Title
              const Text(
                "Book your Assesment Test to know your\nStrength and Areas of Improvement",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5bb3b0),
                ),
              ),

              const SizedBox(height: 40),

              /// Date Field
              InkWell(
                onTap: pickDate,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xff5bb3b0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// Time Buttons
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: times.map((time) {
                  bool isSelected = selectedTime == time;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black
                            : const Color(0xff5bb3b0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 50),

              /// Button
              CustomButton(
                onTap: (){
                  GoRouter.of(context).go('/payment');
                },
                isLoading: false,
                text: "Book Assesment",

              ),
/*              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Let’s Go",
                  style: TextStyle(fontSize: 16),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDate() async {
    DateTime now = DateTime.now();

    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

// safer month handling
    DateTime oneMonthLater = DateTime(now.year, now.month + 1, now.day);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: oneMonthLater,
      selectableDayPredicate: (date) {
        return date.weekday != DateTime.sunday;
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}