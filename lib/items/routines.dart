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
      print('Key: ${entry.key}, Title: ${entry.value.title}, Selected: ${entry.value.isSelected}');
      print(""); // spacing
    }
  }

  printRoutines(){
    savedRoutines.forEach((routineName, exercisesMap) {
      print("Routine: $routineName");

      exercisesMap.forEach((exerciseKey, exercise) {
        print("  $exerciseKey: $exercise");
      });

      print(""); // spacing
    });
  }
}