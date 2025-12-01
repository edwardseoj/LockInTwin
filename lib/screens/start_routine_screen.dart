import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/app_colors.dart';
import 'package:lock_in_twin/screens/start_routine_widgets/build_excercise_row.dart';
import '../items/routines.dart';
import 'home_widgets/appbar.dart';

class StartRoutine extends StatefulWidget {
  final Routine routineObj;
  final int index;

  const StartRoutine({
    super.key,
    required this.routineObj,
    required this.index,
  });

  @override
  State<StartRoutine> createState() => _StartRoutineState();
}

class _StartRoutineState extends State<StartRoutine> {
  Color mainBg = const Color(0xFF302e2e);
  double completionPercent = 0;
  final ScrollController _scrollController = ScrollController();

  Routine get routineObj => widget.routineObj;
  int get index => widget.index;

  void updateCompletionPercent() {
    final routineExercises = routineObj.savedRoutines.values.elementAt(index);
    int totalSets = 0;
    int tappedSets = 0;

    for (var exercise in routineExercises.values) {
      totalSets += exercise.sets.length;
      tappedSets += exercise.sets.where((s) => s['tapped'] == 'true').length;
    }

    setState(() {
      completionPercent = totalSets == 0 ? 0 : (tappedSets / totalSets) * 100;
    });
  }

  double _calculateOpacity(int exerciseIndex, int totalExercises) {
    if (!_scrollController.hasClients) return 1.0;

    // approximate position of exercise in scroll
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.offset;

    // fraction of scroll remaining
    double scrollFraction = (currentScroll / (maxScroll + 1)).clamp(0.0, 1.0);

    // exercises near bottom become dimmer
    double opacity = 1.0 - ((exerciseIndex + 1) / totalExercises) * scrollFraction * 0.5;
    return opacity.clamp(0.5, 1.0); // min opacity 0.5
  }

  @override
  Widget build(BuildContext context) {
    final routineName = routineObj.savedRoutines.keys.elementAt(index);
    final routineExercises = routineObj.savedRoutines.values.elementAt(index);

    return Scaffold(
      backgroundColor: AppColors.screenGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable exercises
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        const SizedBox(height: 10),

                        // Exercises list
                        Column(
                          children: List.generate(routineExercises.length, (idx) {
                            final exercise = routineExercises.values.elementAt(idx);
                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: _calculateOpacity(idx, routineExercises.length),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: BuildExerciseRow(
                                  title: exercise.title,
                                  index: idx,
                                  sets: exercise.sets,
                                  onUpdate: (_) => updateCompletionPercent(),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),


            // Sticky container: progress bar + finish button
            Container(
              color: mainBg,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    value: completionPercent / 100,
                    backgroundColor: Colors.white12,
                    color: AppColors.progressColor,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${completionPercent.toStringAsFixed(0)}% complete",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Finish Routine"),
                          content: Text(
                            "Do you want to finish your routine?\nYou are at ${completionPercent.toStringAsFixed(0)}% complete",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Finish"),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: AppColors.buttonBlue,
                      side: const BorderSide(color: AppColors.borderColor, width: 2,),
                    ),
                    child: const Text(
                      "Finish routine",
                      style: TextStyle(color: AppColors.iconTextWhite, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
