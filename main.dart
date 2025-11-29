import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Example',
      home: Scaffold(
        backgroundColor: Colors.grey[300],
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
      // Make width and height relative to the screen size
      width: screenWidth * 0.9,   // 90% of screen width
      height: screenHeight * 0.8, // 80% of screen height
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF048BA8), Color(0xFF2F2D2E)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quote container: flexible height
          Expanded(
            flex: 6, // proportion of total height
            child: Container(
              width: double.infinity,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20), // spacing

          // Routine name container
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: const Text(
              "Insert Routine Name Here Finished",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1),
            ),
          ),

          const SizedBox(height: 20), // spacing

          // Button: fixed height but fills width
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E4057),
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

