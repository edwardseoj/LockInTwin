import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/screens/create_routine_widgets/continue_button.dart';
import 'package:lock_in_twin/screens/create_routine_widgets/exercise_tile.dart';
import 'package:lock_in_twin/screens/create_routine_widgets/routine_title_form.dart';
import 'package:lock_in_twin/items/exercises.dart';

import '../items/routines.dart';
import 'create_routine_widgets/custom_appbar_1.dart';

class CreateRoutine extends StatefulWidget {
  final Routine routineObj;

  const CreateRoutine({super.key, required this.routineObj});

  @override
  State<StatefulWidget> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  Color mainBg = const Color(0xFF302e2e);

  Routine get routineObj => widget.routineObj;
  final _formKey = GlobalKey<FormState>();
  var _exerciseCounter = 0;

  final Map<String, Exercises> _exercises = {
    "Push Ups": Exercises(
      title: "Push Ups",
      subtitle: "Upper Body",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Squats": Exercises(
      title: "Squats",
      subtitle: "Lower Body",
      icon: const Icon(Icons.airline_seat_legroom_extra_sharp),
      isSelected: false,
    ),
    "Glute Bridges": Exercises(
      title: "Glute Bridges",
      subtitle: "Lower Body",
      icon: const Icon(Icons.airline_seat_legroom_extra_sharp),
      isSelected: false,
    ),
    "Pull Ups": Exercises(
      title: "Pull Ups",
      subtitle: "Upper Body",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank": Exercises(
      title: "Plank",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank1": Exercises(
      title: "Plank1",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank2": Exercises(
      title: "Plank2",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank3": Exercises(
      title: "Plank3",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank4": Exercises(
      title: "Plank4",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank5": Exercises(
      title: "Plank5",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
  };
  final Map<String, Exercises> _selectedExercises = {};

  // helper functions
  void _toggleExercise(String key) {
    setState(() {
      var exObj = _exercises[key]!;
      exObj.isSelected = !exObj.isSelected;

      if (exObj.isSelected) {
        _selectedExercises[key] = exObj;
        _exerciseCounter++;
      } else {
        _selectedExercises.remove(key);
        _exerciseCounter--;
      }

      // Debugging prints
      for (var ex in _selectedExercises.entries) {
        if (kDebugMode) {
          print("Selected Exercise: ${ex.key}");
        }
      }
      if (kDebugMode) {
        print("${exObj.title} selected");
      }
    });
  }

  // main build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CreateRoutineAppBar().buildAppBar(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Routine title
            Container(
              color: mainBg,
              padding: const EdgeInsets.all(16),
              child: RoutineTitleForm(
                formKey: _formKey,
                routineObj: routineObj,
              ),
            ),

            // Exercise list scrollable
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _exercises.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                itemBuilder: (context, index) {
                  String key = _exercises.keys.elementAt(index);
                  return ExerciseTile(
                    exercise: _exercises[key]!,
                    onTap: () => _toggleExercise(key),
                  );
                },
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButton(
                formKey: _formKey,
                routineObj: routineObj,
                selectedExercises: _selectedExercises,
                exerciseCounter: _exerciseCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
