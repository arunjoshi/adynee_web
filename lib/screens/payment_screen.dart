import 'package:adynee_web/widgets/ad_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _paymentScreenState();
}

class _paymentScreenState extends State<PaymentScreen>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: Container(
          width: 900,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Title
              const Text(
                "Voilla, slot is available !!!\nOur Trainer is waiting for you !!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5bb3b0),
                ),
              ),

              const SizedBox(height: 60),

              /// Content Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Left Side (Inputs + Button)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Payment Details Field
                      Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff5bb3b0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "Payment Details",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Placeholder Field
                      Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff5bb3b0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "...............",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// Button
                      CustomButton(text: "Let’s Go", isLoading: false, onTap: (){
                        GoRouter.of(context).go('/confirmation');

                      }),
/*                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        child: const Text("Let’s Go"),
                      ),*/
                    ],
                  ),

                  /// Right Side (Price)
                  const Text(
                    "Rs. 1,999/-",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}