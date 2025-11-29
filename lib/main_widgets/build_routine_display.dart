import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lock_in_twin/items/routines.dart';

class BuildRoutineDisplay extends StatelessWidget {
  final index;
  final Routine routineObj;

  const BuildRoutineDisplay({
    super.key,
    required this.index,
    required this.routineObj,
  });


  @override
  Widget build(BuildContext context) {
    final routineName = routineObj.savedRoutines.keys.elementAt(index);
    final routineExercises = routineObj.savedRoutines.values.elementAt(index);
    final exerciseTitles = routineExercises.values.map((e) => e.title).toList();

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),

        // may edit this for max width
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: Slidable(
            groupTag: '0',
            // do not edit this. this is for auto closing other slidables
            startActionPane: ActionPane(
              extentRatio: 0.30,
              motion: const BehindMotion(),
              children: [
                CustomSlidableAction(
                  onPressed: (context) {
                    print("Edit ${routineObj.savedRoutines[index]}");
                  },
                  backgroundColor: Color(0xFF048BA8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final iconSize = constraints.maxHeight * 0.40; // 45% of tile height
                      return Center(
                        child: Icon(Icons.edit_note_outlined, size: iconSize, color: Colors.white),
                      );
                    },
                  ),
                ),
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.30,
              motion: const BehindMotion(),
              children: [
                CustomSlidableAction(
                  onPressed: (context) {
                    print("Deleted ${routineObj.savedRoutines[index]}");
                  },
                  backgroundColor: Colors.red,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final iconSize = constraints.maxHeight * 0.30; // 45% of tile height
                      return Center(
                        child: Icon(Icons.delete_outline, size: iconSize, color: Colors.white),
                      );
                    },
                  ),
                ),
              ],
            ),

            // design
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey),
              child: Column(
                children: [
                  Text(
                    routineName,
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    exerciseTitles.join(", "),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
