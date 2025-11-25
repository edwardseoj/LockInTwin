import 'exercises.dart';

class Routine{
  String _routineName = "";
  static Map<String, Exercises> finalExercises = {};
  static Map<String, Map<String, Exercises>> savedRoutines = {};

  String get routineName => _routineName;
  set routineName(String value) {
    _routineName = value;

  } // functions for finalExercises
  static copyExercises(Map<String, Exercises> mapToCopy ) {
    finalExercises.clear();
    finalExercises.addAll(mapToCopy);
  }
  static printExercises() {
    for (var entry in finalExercises.entries) {
      print('Key: ${entry.key}, Title: ${entry.value.title}, Selected: ${entry.value.isSelected}');
    }
  }

  addRoutine(){
    savedRoutines[routineName] = Map.from(finalExercises);
  }
}