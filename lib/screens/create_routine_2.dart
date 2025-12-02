import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/routines.dart';
import 'create_routine_widgets/custom_appbar_2.dart';
import '../items/app_colors.dart';

class CreateRoutine2 extends StatefulWidget {
  final Routine routineObj;
  final GlobalKey<FormState> formKey;

  const CreateRoutine2({
    super.key,
    required this.routineObj,
    required this.formKey,
  });

  @override
  State<CreateRoutine2> createState() => _CreateRoutine2State();
}

class _CreateRoutine2State extends State<CreateRoutine2> {
  late List<List<Map<String, String>>> exerciseSets;
  Set<String> invalidFields = {}; // track invalid reps fields

  Routine get routineObj => widget.routineObj;

  @override
  void initState() {
    super.initState();

    // Initialize exerciseSets from Exercises objects
    exerciseSets = routineObj.finalExercises.values.map((exercise) {
      if (exercise.sets.isNotEmpty) {
        return List<Map<String, String>>.from(exercise.sets);
      } else {
        return [
          {"set": "1", "reps": ""},
        ];
      }
    }).toList();
  }

  void updateExerciseSets(int exerciseIndex) {
    routineObj.finalExercises.values
        .elementAt(exerciseIndex)
        .sets = List.from(exerciseSets[exerciseIndex]);
  }

  // Validate all reps before saving
  bool validateAllReps() {
    invalidFields.clear(); // reset previous invalids
    bool allValid = true;

    for (int eIndex = 0; eIndex < exerciseSets.length; eIndex++) {
      for (int sIndex = 0; sIndex < exerciseSets[eIndex].length; sIndex++) {
        final reps = exerciseSets[eIndex][sIndex]['reps'] ?? '';
        if (reps.isEmpty || int.tryParse(reps) == null || int.parse(reps) <= 0) {
          allValid = false;
          invalidFields.add("$eIndex-$sIndex"); // mark invalid
        }
      }
    }

    setState(() {}); // trigger UI update for red borders
    return allValid;
  }

  void showInvalidRepsPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Invalid Input"),
        content: const Text("All reps must be positive numbers and cannot be empty."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void showRoutineDetails() {
    print("------ Routine Details ------");
    routineObj.finalExercises.forEach((key, exercise) {
      print("${exercise.title}:");
      for (var set in exercise.sets) {
        print("  Set: ${set['set']}, Reps: ${set['reps']}");
      }
    });
    print("-----------------------------");
  }

  @override
  Widget build(BuildContext context) {
    Color mainBg = AppColors.screenGrey;
    final routineName = widget.routineObj.savedRoutines.isNotEmpty
        ? widget.routineObj.savedRoutines.keys.last
        : widget.routineObj.routineName;

    return Scaffold(
      backgroundColor: mainBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CreateRoutineAppBar2(routineObj: routineObj,).buildAppBar(context),
      ),
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              routineName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ),

          // Scrollable list of exercises
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: List.generate(
                  routineObj.finalExercises.length,
                      (exerciseIndex) {
                    final exercise =
                    routineObj.finalExercises.values.elementAt(exerciseIndex);

                    return Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.containerColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor, width: 2,),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Routine name with icon
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconTheme(
                                  data: const IconThemeData(
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  child: exercise.icon,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  exercise.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Dynamic sets + reps rows
                          Column(
                            children: List.generate(
                              exerciseSets[exerciseIndex].length,
                                  (setIndex) {
                                final setData =
                                exerciseSets[exerciseIndex][setIndex];

                                return Row(
                                  children: [
                                    // Set #
                                    Expanded(
                                      child: TextFormField(
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          labelText: "Set #",
                                          labelStyle: TextStyle(color: Colors.white70),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white38),
                                          ),
                                        ),
                                        initialValue: setData["set"],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            setData["set"] = value;
                                            updateExerciseSets(exerciseIndex);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    // Reps
                                    Expanded(
                                      child: TextFormField(
                                        style: const TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: "Reps",
                                          labelStyle: const TextStyle(color: Colors.white70),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: invalidFields.contains("$exerciseIndex-$setIndex")
                                                  ? Colors.red
                                                  : Colors.white38,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: invalidFields.contains("$exerciseIndex-$setIndex")
                                                  ? Colors.red
                                                  : Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        initialValue: setData["reps"],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            setData["reps"] = value;
                                            updateExerciseSets(exerciseIndex);

                                            if (int.tryParse(value) != null && int.parse(value) > 0) {
                                              invalidFields.remove("$exerciseIndex-$setIndex");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    // Delete row
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (exerciseSets[exerciseIndex].length > 1) {
                                            exerciseSets[exerciseIndex].removeAt(setIndex);
                                            updateExerciseSets(exerciseIndex);
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Add set button
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  int nextSetNumber = exerciseSets[exerciseIndex].length + 1;
                                  exerciseSets[exerciseIndex].add({
                                    "set": nextSetNumber.toString(),
                                    "reps": "",
                                  });
                                  updateExerciseSets(exerciseIndex);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonBlue, // your AppColor
                                side: const BorderSide(color: AppColors.borderColor, width: 2), // black border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // keep rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: const Text(
                                "Add Set",
                                style: TextStyle(
                                  color: Colors.white, // text color
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Save Routine button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                if (validateAllReps()) {
                  routineObj.addRoutine();
                  showRoutineDetails();
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  showInvalidRepsPopup();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue, // your app color
                side: const BorderSide(color: Colors.black, width: 2), // black border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Save Routine & Show Details",
                style: TextStyle(
                  color: Colors.white, // text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
      ),
    );
  }
}
