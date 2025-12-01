import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/exercises.dart';

import 'package:lock_in_twin/items/routines.dart';
import 'package:lock_in_twin/screens/create_routine_2.dart';

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
          formKey.currentState!.save();
        }
        routineObj.copyExercises(selectedExercises);
        routineObj.printExercises();
        routineObj.addRoutine();
        routineObj.printRoutines();


        // moves to home page
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => CreateRoutine2(routineObj: routineObj, formKey: formKey),
              settings: const RouteSettings(name: "/CreateRoutine2"),
            )
        );
        

        if (kDebugMode) {
          print("Routine Saved");
        }
      },

      // parent design
      // COLORING: Button Color
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _continueButtonDesign(),
      ),
    );
  }


  // Helper widgets
  List<Widget> _continueButtonDesign() {
    var children = <Widget>[];

    children.add(
      SizedBox(
        height: 25,
        width: 25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(

            // COLORING: Inside the Button - Circle Exercise Counter Color, beside text
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


      // COLORING: Inside the Button - Text Color
      Text('Continue', style: TextStyle(fontSize: 18, color: Colors.white)),
    );


    // COLORING: Inside the Button - Arrow Icon Color
    children.add(Icon(Icons.navigate_next, color: Colors.white));

    return children;
  }
}