import 'package:flutter/foundation.dart';

import 'exercises.dart';

class Routine{
  String routineName = "";

  static Map<String, Exercises> finalExercises = {};
  static Map<String, Map<String, Exercises>> savedRoutines = {}; // functions for finalExercises
  static copyExercises(Map<String, Exercises> mapToCopy ) {
    finalExercises.clear();
    finalExercises.addAll(mapToCopy);
  }
  addRoutine(){
    savedRoutines[routineName] = Map.from(finalExercises);
  }





  //debugging functions
  printExercises() {
    for (var entry in finalExercises.entries) {
      if (kDebugMode) {
        print('Key: ${entry.key}, Title: ${entry.value.title}, Selected: ${entry.value.isSelected}');
      }
      if (kDebugMode) {
        print("");
      } // spacing
    }
  }

  printRoutines(){
    savedRoutines.forEach((routineName, exercisesMap) {
      if (kDebugMode) {
        print("Routine: $routineName");
      }

      exercisesMap.forEach((exerciseKey, exercise) {
        if (kDebugMode) {
          print("  $exerciseKey: $exercise");
        }
      });

      if (kDebugMode) {
        print("");
      } // spacing
    });
  }
}