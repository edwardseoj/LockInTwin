import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/app_colors.dart';
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
  Color mainBg = AppColors.screenGrey;

  Routine get routineObj => widget.routineObj;
  final _formKey = GlobalKey<FormState>();
  var _exerciseCounter = 0;

  final Map<String, Exercises> _exercises = {
    "Push Ups": Exercises(
      title: "Push Ups",
      subtitle: "Upper Body",
      icon: Image.asset('assets/icons/push-ups.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Squats": Exercises(
      title: "Squats",
      subtitle: "Lower Body",
      icon: Image.asset('assets/icons/squats.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Glute Bridges": Exercises(
      title: "Glute Bridges",
      subtitle: "Lower Body",
      icon: Image.asset('assets/icons/glutes.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Pull Ups": Exercises(
      title: "Pull Ups",
      subtitle: "Upper Body",
      icon: Image.asset('assets/icons/pull-ups.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank": Exercises(
      title: "Plank",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank1": Exercises(
      title: "Plank1",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank2": Exercises(
      title: "Plank2",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank3": Exercises(
      title: "Plank3",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank4": Exercises(
      title: "Plank4",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
    "Plank5": Exercises(
      title: "Plank5",
      subtitle: "Core",
      icon: Image.asset('assets/icons/planks.png', height: 40, width: 40),
      isSelected: false,
    ),
  };
  final Map<String, Exercises> _selectedExercises = {};
  bool _isHoveringContinueButton = false;

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
            Container(
              color: mainBg,
              padding: const EdgeInsets.all(16),
              child: RoutineTitleForm(
                formKey: _formKey,
                routineObj: routineObj,
              ),
            ),

            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _exercises.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                itemBuilder: (context, index) {
                  String key = _exercises.keys.elementAt(index);
                  return LongPressDraggable<Exercises>(
                    data: _exercises[key],

                    feedback: Transform.scale(
                      scale: 1.1,
                      child: _dragFeedback(_exercises[key]!),
                    ),

                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: ExerciseTile(
                        exercise: _exercises[key]!,
                        onTap: () => _toggleExercise(key),
                      ),
                    ),

                    child: ExerciseTile(
                      exercise: _exercises[key]!,
                      onTap: () => _toggleExercise(key),
                    ),
                  );
                },
              ),
            ),

            DragTarget<Exercises>(
              onAcceptWithDetails: (details) {
                final exercise = details.data;
                setState(() {
                  exercise.isSelected = true;
                  _selectedExercises[exercise.title] = exercise;
                  _exerciseCounter++;
                  _isHoveringContinueButton = false; // reset hover
                });
              },
              onMove: (details) {
                setState(() {
                  _isHoveringContinueButton = true;
                });
              },
              onLeave: (details) {
                setState(() {
                  _isHoveringContinueButton = false;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return ContinueButton(
                  formKey: _formKey,
                  routineObj: routineObj,
                  selectedExercises: _selectedExercises,
                  exerciseCounter: _exerciseCounter,
                  isHighlighted: _isHoveringContinueButton || candidateData.isNotEmpty,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _dragFeedback(Exercises exercise) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: exercise.icon,
            ),
            const SizedBox(width: 8),
            Text(
              exercise.title,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}
