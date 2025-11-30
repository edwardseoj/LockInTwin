import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/exercises.dart';

import 'package:lock_in_twin/items/routines.dart';

class ContinueButton extends StatelessWidget{
  final GlobalKey<FormState> formKey;
  final Routine routineObj;
  final Map<String, Exercises> selectedExercises;
  final int exerciseCounter;

  const ContinueButton({
    super.key,
    required this.formKey,
    required this.routineObj,
    required this.selectedExercises,
    required this.exerciseCounter
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Save routine logic
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();   // <-- This triggers onSaved
        }
        routineObj.copyExercises(selectedExercises);
        routineObj.printExercises();
        routineObj.addRoutine();
        routineObj.printRoutines();

        // Move to main page
        Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => MyApp()),
        //       (Route<dynamic> route) => false,
        // );

        if (kDebugMode) {
          print("Routine Saved");
        }
      },

      // parent design
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _continueButtonDesign(),
      ),
    );
  }

  List<Widget> _continueButtonDesign() {
    // children widgets list
    var children = <Widget>[];

    children.add(
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
            textAlign: TextAlign.center,
            exerciseCounter.toString(),
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ),
    );
    children.add(SizedBox(width: 10));
    children.add(
      Text('Continue', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
    children.add(Icon(Icons.navigate_next, color: Colors.white));

    return children;
  }
}