import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/routines.dart';
import '../items/app_colors.dart';
import 'home_widgets/appbar.dart';

class FinishedRoutine extends StatefulWidget {
  final double completionPercent;
  const FinishedRoutine({super.key, required this.completionPercent});

  @override
  State<FinishedRoutine> createState() => _FinishedRoutineState();
}

class _FinishedRoutineState extends State<FinishedRoutine> {
  final routineObj = Routine.instance;

  static const Map<int, String> routineQuotes = {
    1: "Push yourself, because no one else will.",
    2: "Success doesn't come from what you do occasionally, it comes from what you do consistently.",
    3: "You didn't come this far to only come this far.",
    4: "Small steps every day lead to big results.",
    5: "Discipline is the bridge between goals and accomplishment.",
    6: "Your only limit is your mind.",
    7: "Don't stop when you're tired. Stop when you're done.",
    8: "The pain you feel today will be the strength you feel tomorrow.",
    9: "It always seems impossible until it's done.",
    10: "You are stronger than you think.",
    11: "Consistency is more important than perfection.",
    12: "Wake up with determination. Go to bed with satisfaction.",
    13: "The secret of getting ahead is getting started.",
    14: "Every accomplishment starts with every decision you try.",
    15: "You don't have to be extreme, just consistent.",
    16: "Great things never come from comfort zones.",
    17: "One routine at a time, you're doing great",
    18: "Fall in love with the process and results will come.",
    19: "Motivation gets you started. Habit keeps you going.",
    20: "You crushed it. Now go again tomorrow."
  };

  String getRandomQuote() {
    final random = Random();
    final keys = routineQuotes.keys.toList();
    final randomKey = keys[random.nextInt(keys.length)];
    return routineQuotes[randomKey]!;
  }

  @override
  Widget build(BuildContext context) {
    final routineName = routineObj.routineName.isNotEmpty
        ? routineObj.routineName
        : "Your Routine";

    final quote = getRandomQuote();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomAppBar(),
        ),
        backgroundColor: AppColors.screenGrey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.containerColor, // lighter gray
                    borderRadius: BorderRadius.circular(20),

                    border: Border.all(color: AppColors.borderColor, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"$quote"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Routine $routineName finished",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.completionPercent.toStringAsFixed(0)}% complete",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      color: AppColors.borderColor,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
