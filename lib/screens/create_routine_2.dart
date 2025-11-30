import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/routines.dart';

import 'create_routine_widgets/create_routine_appbar.dart';

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

  @override
  void initState() {
    super.initState();

    /// Create 1 empty row (set+reps) for each exercise
    exerciseSets = List.generate(
      widget.routineObj.savedRoutines.length,
      (_) => [
        {"set": "", "reps": ""},
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color mainBg = const Color(0xFF302e2e);
    final routineName = widget.routineObj.savedRoutines.keys.elementAt(
      widget.routineObj.savedRoutines.length - 1,
    );

    return Scaffold(
      backgroundColor: mainBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CreateRoutineAppBar().buildAppBar(context),
      ),

      body: Column(
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

          Expanded(
            child: ListView.builder(
              itemCount: widget.routineObj.savedRoutines.length,
              itemBuilder: (context, exerciseIndex) {
                final exerciseMap = widget.routineObj.savedRoutines.values
                    .elementAt(exerciseIndex);

                final exerciseTitle = exerciseMap.values.first.title;

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
                      /// Exercise Title
                      Text(
                        exerciseTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// ------- SET + REPS dynamic rows -------
                      Column(
                        children: List.generate(
                          exerciseSets[exerciseIndex].length,
                          (setIndex) {
                            return Row(
                              children: [
                                /// SET TextField
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Set ${setIndex + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                /// REPS TextField
                                Expanded(
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelText: "Reps",
                                      labelStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      exerciseSets[exerciseIndex][setIndex]["reps"] =
                                          value;
                                    },
                                  ),
                                ),

                                const SizedBox(width: 10),

                                /// Delete Row Icon
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (exerciseSets[exerciseIndex].length >
                                          1) {
                                        exerciseSets[exerciseIndex].removeAt(
                                          setIndex,
                                        );
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

                      /// ------- ADD SET BUTTON -------
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              exerciseSets[exerciseIndex].add({
                                "set": "",
                                "reps": "",
                              });
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
        ],
      ),
    );
  }
}
