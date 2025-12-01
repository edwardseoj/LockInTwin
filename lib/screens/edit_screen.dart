import 'package:flutter/material.dart';
import 'create_routine_widgets/custom_appbar_2.dart';
import '../items/routines.dart';

class EditRoutine extends StatefulWidget {
  final Routine routineObj;

  const EditRoutine({super.key, required this.routineObj});

  @override
  State<EditRoutine> createState() => _EditRoutineState();
}

class _EditRoutineState extends State<EditRoutine> {
  late List<List<Map<String, String>>> exerciseSets;
  Set<String> invalidFields = {}; // track invalid reps fields
  late TextEditingController _routineNameController;

  Routine get routineObj => widget.routineObj;

  @override
  void initState() {
    super.initState();

    // Initialize routine name controller
    _routineNameController = TextEditingController(text: routineObj.routineName);

    // Initialize exerciseSets from existing exercises
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

  bool validateAllReps() {
    invalidFields.clear();
    bool allValid = true;

    for (int eIndex = 0; eIndex < exerciseSets.length; eIndex++) {
      for (int sIndex = 0; sIndex < exerciseSets[eIndex].length; sIndex++) {
        final reps = exerciseSets[eIndex][sIndex]['reps'] ?? '';
        if (reps.isEmpty || int.tryParse(reps) == null || int.parse(reps) <= 0) {
          allValid = false;
          invalidFields.add("$eIndex-$sIndex");
        }
      }
    }

    setState(() {});
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
            onPressed: () => Navigator.pop(context,true),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void saveRoutineEdits() {
    routineObj.routineName = _routineNameController.text;
    for (int i = 0; i < exerciseSets.length; i++) {
      routineObj.finalExercises.values
          .elementAt(i)
          .sets = List.from(exerciseSets[i]);
    }

    // Optionally, you can also update the savedRoutines map if needed
    routineObj.savedRoutines[routineObj.routineName] = routineObj.finalExercises;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color mainBg = const Color(0xFF302e2e);

    return Scaffold(
      backgroundColor: mainBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CreateRoutineAppBar2(routineObj: routineObj).buildAppBar(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Editable routine name
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _routineNameController,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                decoration: const InputDecoration(
                  labelText: "Routine Name",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
              ),
            ),

            // Scrollable exercises
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
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Exercise title with icon
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.fitness_center,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    exercise.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Dynamic sets + reps
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelText: "Set #",
                                            labelStyle:
                                            TextStyle(color: Colors.white70),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white38),
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                            labelText: "Reps",
                                            labelStyle: const TextStyle(
                                                color: Colors.white70),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: invalidFields.contains(
                                                    "$exerciseIndex-$setIndex")
                                                    ? Colors.red
                                                    : Colors.white38,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: invalidFields.contains(
                                                    "$exerciseIndex-$setIndex")
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
                                              if (int.tryParse(value) != null &&
                                                  int.parse(value) > 0) {
                                                invalidFields
                                                    .remove("$exerciseIndex-$setIndex");
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
                                            if (exerciseSets[exerciseIndex].length >
                                                1) {
                                              exerciseSets[exerciseIndex]
                                                  .removeAt(setIndex);
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
                                    int nextSetNumber =
                                        exerciseSets[exerciseIndex].length + 1;
                                    exerciseSets[exerciseIndex].add({
                                      "set": nextSetNumber.toString(),
                                      "reps": "",
                                    });
                                    updateExerciseSets(exerciseIndex);
                                  });
                                },
                                child: const Text("Add Set"),
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

            // Save edits button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  if (validateAllReps()) {
                    saveRoutineEdits();
                  } else {
                    showInvalidRepsPopup();
                  }
                },
                child: const Text("Save Edits"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
