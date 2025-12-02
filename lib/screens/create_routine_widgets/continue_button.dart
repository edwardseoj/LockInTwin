import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/app_colors.dart';
import 'package:lock_in_twin/items/exercises.dart';
import 'package:lock_in_twin/items/routines.dart';
import 'package:lock_in_twin/screens/create_routine_2.dart';

class ContinueButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Routine routineObj;
  final Map<String, Exercises> selectedExercises;
  final int exerciseCounter;

  // 👇 ADD THIS
  final bool isHighlighted;

  const ContinueButton({
    super.key,
    required this.formKey,
    required this.routineObj,
    required this.selectedExercises,
    required this.exerciseCounter,

    // 👇 ADD THIS DEFAULT VALUE
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }

        routineObj.copyExercises(selectedExercises);
        routineObj.printExercises();
        routineObj.addRoutine();
        routineObj.printRoutines();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CreateRoutine2(routineObj: routineObj, formKey: formKey),
            settings: const RouteSettings(name: "/CreateRoutine2"),
          ),
        );

        if (kDebugMode) print("Routine Saved");
      },

      style: ElevatedButton.styleFrom(
        // 👇 CHANGE BACKGROUND COLOR BASED ON HIGHLIGHT
        backgroundColor: isHighlighted
            ? Colors.blueAccent   // highlight color
            : AppColors.buttonBlue,

        side: const BorderSide(color: Colors.black, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _continueButtonDesign(),
      ),
    );
  }

  // Helper UI
  List<Widget> _continueButtonDesign() {
    return [
      SizedBox(
        height: 25,
        width: 25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            exerciseCounter.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ),
      const SizedBox(width: 10),
      const Text('Continue', style: TextStyle(fontSize: 18, color: Colors.white)),
      const Icon(Icons.navigate_next, color: Colors.white),
    ];
  }
}
