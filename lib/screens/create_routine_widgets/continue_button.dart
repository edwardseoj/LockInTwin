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
        // Validate the form
        if (!formKey.currentState!.validate()) {
          if (kDebugMode) print("Form is invalid, cannot continue");
          return; // stop if form invalid
        }

        // Check if at least one exercise is selected
        if (exerciseCounter == 0) {
          // Optionally, show a SnackBar to inform user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select at least one exercise'),
              duration: Duration(seconds: 2),
            ),
          );
          if (kDebugMode) print("No exercises selected, cannot continue");
          return; // stop navigation
        }

        // Save form fields
        formKey.currentState!.save();

        // Copy selected exercises into routine
        routineObj.copyExercises(selectedExercises);
        routineObj.printExercises();
        routineObj.addRoutine();
        routineObj.printRoutines();

        // Navigate to next screen
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
        backgroundColor: isHighlighted ? Colors.blueAccent : AppColors.buttonBlue,
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
