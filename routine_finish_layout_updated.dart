import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  // Gradient colors
  static const Color gradientStart = Color(0xFF048BA8);
  static const Color gradientEnd   = Color(0xFF2F2D2E);

  // Button color
  static const Color buttonBlue    = Color(0xFF2E4057);

  // Container background
  static const Color containerWhite = Colors.white;

  // Screen background
  static const Color screenGrey = Color(0xFFE0E0E0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Example',
      home: Scaffold(
        backgroundColor: AppColors.screenGrey, // ← USING COLOR CLASS
        body: const Center(
          child: CustomContainer(),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.8,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(     // ← removed const so it can use AppColors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradientStart,  // ← USING COLOR CLASS
            AppColors.gradientEnd,    // ← USING COLOR CLASS
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quote container
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: AppColors.containerWhite,   // ← USING COLOR CLASS
            ),
          ),

          const SizedBox(height: 20),

          // Routine name container
          Container(
            alignment: Alignment.center,
            color: AppColors.containerWhite,      // ← USING COLOR CLASS
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: const Text(
              "Insert Routine Name Here Finished",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1),
            ),
          ),

          const SizedBox(height: 20),

          // Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,   // ← USING COLOR CLASS
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Back To Home Page",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
